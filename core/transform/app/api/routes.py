from fastapi import APIRouter, UploadFile, File, HTTPException
from fastapi.responses import FileResponse, HTMLResponse, PlainTextResponse

from app.models import TextRequest
from app.services.embedding import generate_embedding
import tempfile
import shutil
import os
from preview_generator.manager import PreviewManager
import mimetypes

router = APIRouter()

cache_dir = "/tmp/preview_cache"
os.makedirs(cache_dir, exist_ok=True)
manager = PreviewManager(cache_dir, create_folder=True)


@router.post("/generate/preview")
async def generate_preview(file: UploadFile = File(...)):
    suffix = os.path.splitext(file.filename)[1] or ""
    with tempfile.NamedTemporaryFile(delete=False, suffix=suffix) as tmp:
        shutil.copyfileobj(file.file, tmp)
        input_path = tmp.name
    try:
        mime_type = file.content_type or mimetypes.guess_type(file.filename)[0] or ""
        if mime_type.startswith("image/"):
            output_path = manager.get_jpeg_preview(input_path)
            return FileResponse(output_path, media_type="image/jpeg", filename="preview.jpg")
        elif mime_type in ("application/pdf",):
            output_path = manager.get_pdf_preview(input_path)
            return FileResponse(output_path, media_type="application/pdf", filename="preview.pdf")
        elif mime_type in ("application/msword",
                           "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                           "application/vnd.oasis.opendocument.text"):
            output_path = manager.get_html_preview(input_path)
            with open(output_path, "r", encoding="utf-8") as f:
                html_content = f.read()
            return HTMLResponse(content=html_content)
        elif mime_type.startswith("text/"):
            output_path = manager.get_text_preview(input_path)
            with open(output_path, "r", encoding="utf-8") as f:
                text_content = f.read()
            return PlainTextResponse(content=text_content)
        else:
            return FileResponse(input_path, media_type=mime_type or "application/octet-stream", filename=file.filename)
    finally:
        os.unlink(input_path)


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
