from fastapi import APIRouter, UploadFile, File, HTTPException
from fastapi.responses import FileResponse
from app.models import TextRequest
from app.services.embedding import generate_embedding
import tempfile
import shutil
import os
from preview_generator.manager import PreviewManager

router = APIRouter()

cache_dir = "/tmp/preview_cache"
os.makedirs(cache_dir, exist_ok=True)
manager = PreviewManager(cache_dir, create_folder=True)


@router.post("/generate/preview")
async def generate_preview(file: UploadFile = File(...)):
    with tempfile.NamedTemporaryFile(delete=False, suffix=os.path.splitext(file.filename)[-1]) as tmp:
        shutil.copyfileobj(file.file, tmp)
        input_path = tmp.name
    try:
        if not manager.has_pdf_preview(input_path):
            raise HTTPException(status_code=400, detail="Cannot generate preview for this file type")
        output_path = manager.get_pdf_preview(input_path, page=0)
        return FileResponse(
            path=output_path,
            filename="preview.pdf",
            media_type="application/pdf"
        )
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
