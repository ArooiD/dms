FROM python:3.9-slim AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    libreoffice \
    openjdk-17-jre-headless \
    poppler-utils \
    unoconv \
    ffmpeg \
    ghostscript \
    libmagic1 \
    libimage-exiftool-perl \
    imagemagick \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

FROM base AS dependency

COPY requirements.txt ./
COPY healthcheck.py ./

RUN pip install --no-cache-dir -r requirements.txt

FROM dependency AS runtime

EXPOSE 8000

CMD ["gunicorn", "app.main:app", "-w", "25", "-k", "uvicorn.workers.UvicornWorker", "--bind", "0.0.0.0:8000"]
