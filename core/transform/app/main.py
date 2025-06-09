from fastapi import FastAPI, HTTPException, Request
from pydantic import BaseModel
from contextlib import asynccontextmanager
from starlette.datastructures import State

from app.infra.db import get_postgres_connection
from app.infra.messaging import get_rabbitmq_connection

from app.api import router as api_router


class TextRequest(BaseModel):
    text: str


@asynccontextmanager
async def lifespan(app: FastAPI):
    app.state.db = get_postgres_connection()
    app.state.rabbitmq = get_rabbitmq_connection()
    yield
    app.state.db.close()
    app.state.rabbitmq.close()


app = FastAPI(lifespan=lifespan)
app.state: State  # type: ignore
app.include_router(api_router)
