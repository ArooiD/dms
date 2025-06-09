from fastapi import APIRouter
from app.api.routes import router as api_router  # Импортируем роутер из routes.py

router = APIRouter()
router.include_router(api_router)
