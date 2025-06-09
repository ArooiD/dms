from fastapi import APIRouter, HTTPException, Request
from app.models import TextRequest
from app.services.embedding import generate_embedding

router = APIRouter()


@router.post("/embedding/generate")
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
