from fastapi import FastAPI
from contextlib import asynccontextmanager
from app.infra.db import get_postgres_connection
from app.infra.messaging import get_rabbitmq_connection
from starlette.datastructures import State


@asynccontextmanager
async def lifespan(app: FastAPI):
    app.state.db = get_postgres_connection()
    # app.state.rabbitmq = get_rabbitmq_connection()
    yield
    app.state.db.close()
    # app.state.rabbitmq.close()

app = FastAPI(lifespan=lifespan)
app.state: State  # type: ignore

from app.api.health import router

app.include_router(router)
