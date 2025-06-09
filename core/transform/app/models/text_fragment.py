from pydantic import BaseModel, Field
from uuid import UUID
from typing import Optional, List


class TextFragment(BaseModel):
    document_id: UUID
    chunk_id: UUID
    text: str
    embedding: Optional[List[float]] = None
