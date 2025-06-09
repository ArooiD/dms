import psycopg2
from psycopg2.extras import RealDictCursor
import os


def get_postgres_connection():
    conn = psycopg2.connect(
        host=os.getenv("POSTGRES_HOST", "infra.psql"),
        port=os.getenv("POSTGRES_PORT", 5432),
        database=os.getenv("POSTGRES_DB", "dms"),
        user=os.getenv("POSTGRES_USER", "postgres"),
        password=os.getenv("POSTGRES_PASSWORD", "root"),
        cursor_factory=RealDictCursor
    )
    return conn
