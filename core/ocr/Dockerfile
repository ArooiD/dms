FROM python:3.9-slim AS base

RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    poppler-utils \
    curl \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \\
    libmagic1 \
    && rm -rf /var/lib/apt/lists/*

FROM base AS dependency

COPY requirements.txt ./
COPY healthcheck.py ./

RUN pip install --no-cache-dir -r requirements.txt

FROM dependency AS runtime

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload", "--reload-dir", "app"]
