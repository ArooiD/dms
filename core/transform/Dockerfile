FROM python:3.9-slim AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    libreoffice \
    openjdk-11-jre-headless \
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

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload", "--reload-dir", "app"]
