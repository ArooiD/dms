import os
import time
import uuid

import httpx
from fastapi import APIRouter, UploadFile, File, HTTPException, Query, Form
import magic
import io

import re
from collections import Counter
from docx import Document
from PyPDF2 import PdfReader
import pytesseract
from PIL import Image

router = APIRouter()
BASE_PATH = "/analyse"
STOP = set("""и в не на с к по для от что это как он она они из у о""".split())


def keywords(text, k=10):
    words = re.findall(r"[А-Яа-яA-Za-z]{4,}", text.lower())
    common = (w for w in words if w not in STOP)
    most = Counter(common).most_common(k)
    return [w for w, _ in most]


import pytesseract
from PIL import Image


async def parse_file(file: io.BytesIO, mime_type: str):
    print(f"[INFO] Parsing file")
    print(f"[INFO] MIME type: {mime_type}")

    text = ""

    if mime_type == "text/plain":
        text = file.read().decode("utf-8", errors="ignore")

    elif mime_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
        try:
            doc = Document(file)
            text = "\n".join(paragraph.text for paragraph in doc.paragraphs)
        except KeyError as e:
            raise Exception(f"Invalid or corrupted .docx file: {e}")

    elif mime_type == "application/pdf":
        reader = PdfReader(file)
        for page in reader.pages:
            extracted = page.extract_text()
            if extracted:
                text += extracted + "\n"

    elif mime_type == "image/png":
        try:
            file.seek(0)
            image = Image.open(file)
            text = pytesseract.image_to_string(image, lang="rus+eng")
        except Exception as e:
            raise Exception(f"OCR failed: {e}")

    else:
        raise Exception(f"Unsupported file type: {mime_type}")

    keywords_list = keywords(text)
    print("[INFO] Extracted keywords:")
    print(keywords_list)

    return text


@router.get(BASE_PATH + "/health")
def health_check():
    return {"status": "ok"}


@router.get(BASE_PATH + "/")
def root():
    return {"status": "hello"}


@router.post(BASE_PATH + "/upload")
async def upload_file(
        pid: str = Form(..., description="pid"),
        did: str = Form(..., description="did"),
        ver: int = Form(..., description="ver"),
        file: UploadFile = File(...)
):
    if not file.filename:
        raise HTTPException(status_code=400, detail="Empty file")

    contents = await file.read()
    await file.seek(0)

    file_extension = os.path.splitext(file.filename)[1].lower()
    mime = magic.from_buffer(contents, mime=True)

    if file_extension in [".docx"] and mime == "text/html":
        mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    # print(f"BEFORE pid:{pid} did:{did}")
    # pid = uuid.UUID(str(pid))
    # did = uuid.UUID(str(did))
    # print(f"pid:{pid} did:{did}")

    try:
        text = await parse_file(io.BytesIO(contents), mime)
        data = {
            "pid": pid,
            "did": did,
            "ver": ver,
            "frags": parse_text(text, _split_symbol=" . \n") if file_extension == ".pdf" else parse_text(text,
                                                                                                         _split_symbol="\n"),
        }

        try:
            with httpx.Client(timeout=None) as client:
                request = client.post(
                    "http://core.search:8000/index/document",
                    json=data
                )
            # Проверяем, успешен ли запрос
            request.raise_for_status()  # выбросит исключение для 4xx/5xx
        except httpx.RequestError as exc:
            # Любая сетевая ошибка (например, нет соединения)
            raise HTTPException(
                status_code=502,
                detail=f"Request to external service failed: {exc}"
            )
        except httpx.HTTPStatusError as exc:
            # Сервис вернул 4xx или 5xx
            raise HTTPException(
                status_code=exc.response.status_code,
                detail=f"External service returned error: {exc.response.text}"
            )
        # Формируем frags
        frags = (
            parse_text(text, _split_symbol=" . \n")
            if file_extension == ".pdf"
            else parse_text(text, _split_symbol="\n")
        )

        return {
            "pid": pid,
            "did": did,
            "ver": ver,
            "status_request_code": request.status_code,
            "frags": frags
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error parsing file: {str(e)}")


def parse_text(text: str, _split_symbol):
    array = []
    for line in text.split(_split_symbol):
        if is_empty(line):
            continue
        elif line[0].islower() and len(array) != 0:
            array[-1] += f' {line.strip()}'.replace("\n", "")
        else:
            array.append(line.strip().replace("\n", ""))
    return array


def is_empty(line: str):
    return not line or line.strip() == ""


if __name__ == '__main__':
    # BEFORE
    pid = "84055427-00ea-41e0-800a-e3e31f8acefc"
    did = "db2663b1-c0c8-448d-a83d-b9406039f86d"

    print(uuid.UUID(pid))
    print(uuid.UUID(did))
