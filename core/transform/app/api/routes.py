from fastapi import APIRouter, File, UploadFile, HTTPException
from fastapi.responses import FileResponse, HTMLResponse, PlainTextResponse
import os
import shutil
import tempfile
import mimetypes
import subprocess
import logging

from preview_generator.exception import UnavailablePreviewType
from preview_generator.manager import PreviewManager

from app.models import TextRequest
from app.services.embedding import generate_embedding

router = APIRouter()
logger = logging.getLogger("app.api.routes")

# Каталог для кеша превью
preview_cache_dir = "/tmp/preview_cache"
os.makedirs(preview_cache_dir, exist_ok=True)

manager = PreviewManager(cache_folder_path=preview_cache_dir, create_folder=True)


def convert_to_html_with_soffice(input_path: str, output_dir: str) -> str:
    """Резервный способ — через LibreOffice CLI"""
    try:
        result = subprocess.run(
            ["soffice", "--headless", "--convert-to", "html", input_path, "--outdir", output_dir],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        base_name = os.path.splitext(os.path.basename(input_path))[0]
        html_path = os.path.join(output_dir, f"{base_name}.html")
        if not os.path.exists(html_path):
            raise RuntimeError("HTML файл не создан LibreOffice")
        return html_path
    except subprocess.CalledProcessError as e:
        logger.error(f"[FALLBACK] LibreOffice не смог сконвертировать файл: {e.stderr.decode()}")
        raise HTTPException(status_code=500, detail="LibreOffice failed to convert to HTML")


@router.post("/generate/preview")
async def generate_preview(file: UploadFile = File(...)):
    logger.info(f"[1] Начинаем обработку файла: {file.filename}")
    suffix = os.path.splitext(file.filename)[1] or ""
    with tempfile.NamedTemporaryFile(delete=False, suffix=suffix) as tmp:
        shutil.copyfileobj(file.file, tmp)
        input_path = tmp.name
    logger.info(f"[1] Файл сохранён во временное хранилище: {input_path}")

    output_path = None

    try:
        mime_type = file.content_type or mimetypes.guess_type(file.filename)[0] or ""
        logger.info(f"[2] MIME-тип определён: {mime_type}")

        if mime_type.startswith("image/"):
            logger.info(f"[3] Обработка изображения")
            try:
                output_path = manager.get_jpeg_preview(input_path)
                logger.info(f"[3] JPEG превью создано: {output_path}")
                return FileResponse(output_path, media_type="image/jpeg", filename="preview.jpg")
            except UnavailablePreviewType:
                logger.error(f"[3] JPEG превью не поддерживается")
                raise HTTPException(status_code=415, detail="JPEG preview not supported")

        elif mime_type == "application/pdf":
            logger.info(f"[4] Обработка PDF")
            try:
                output_path = manager.get_pdf_preview(input_path)
                logger.info(f"[4] PDF превью создано: {output_path}")
                return FileResponse(output_path, media_type="application/pdf", filename="preview.pdf")
            except UnavailablePreviewType:
                logger.error(f"[4] PDF превью не поддерживается")
                raise HTTPException(status_code=415, detail="PDF preview not supported")

        elif mime_type in (
                "application/msword",
                "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                "application/vnd.oasis.opendocument.text"
        ):
            logger.info(f"[5] Обработка офисного документа")
            try:
                output_path = manager.get_html_preview(input_path)
                logger.info(f"[5] HTML превью создано через preview-generator: {output_path}")
            except UnavailablePreviewType:
                logger.warning(f"[5] Preview-generator не справился, пробуем LibreOffice напрямую")
                output_path = convert_to_html_with_soffice(input_path, "/tmp")
                logger.info(f"[5-FALLBACK] HTML превью создано LibreOffice: {output_path}")

            with open(output_path, "r", encoding="utf-8") as f:
                html_content = f.read()
            return HTMLResponse(content=html_content)

        elif mime_type.startswith("text/"):
            logger.info(f"[6] Обработка текстового файла")
            try:
                output_path = manager.get_text_preview(input_path)
                logger.info(f"[6] Text превью создано: {output_path}")
                with open(output_path, "r", encoding="utf-8") as f:
                    text_content = f.read()
                return PlainTextResponse(content=text_content)
            except UnavailablePreviewType:
                logger.error(f"[6] Text превью не поддерживается")
                raise HTTPException(status_code=415, detail="Text preview not supported")

        else:
            logger.warning(f"[7] Неподдерживаемый MIME-тип: {mime_type}")
            raise HTTPException(status_code=415, detail="Unsupported file type for preview")

    finally:
        logger.info(f"[8] Удаляем временный файл: {input_path}")
        if os.path.exists(input_path):
            os.unlink(input_path)
        if output_path and os.path.exists(output_path):
            try:
                os.unlink(output_path)
                logger.info(f"[8] Удаляем сгенерированное превью: {output_path}")
            except Exception:
                pass


@router.post("/generate/embedding")
async def generate_embedding_endpoint(
        payload: TextRequest
):
    text = payload.text
    if not text.strip():
        raise HTTPException(status_code=400, detail="Text is required")
    embedding = generate_embedding(text)
    return {"embedding": embedding, "length": len(embedding)}


@router.get("/health")
def health_check():
    return {"status": "ok"}


@router.get("/")
def root():
    return {"status": "hello"}
