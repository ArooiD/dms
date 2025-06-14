import os
import time

import httpx
from fastapi import APIRouter, UploadFile, File, HTTPException, Query, Form
import magic
import io

import re
from collections import Counter
from docx import Document
from PyPDF2 import PdfReader

router = APIRouter()
BASE_PATH = "/analyse"
STOP = set("""и в не на с к по для от что это как он она они из у о""".split())


def keywords(text, k=10):
    words = re.findall(r"[А-Яа-яA-Za-z]{4,}", text.lower())
    common = (w for w in words if w not in STOP)
    most = Counter(common).most_common(k)
    return [w for w, _ in most]


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
            # DOCX может содержать нестандартные XML теги
            raise Exception(f"Invalid or corrupted .docx file: {e}")

    elif mime_type == "application/pdf":
        reader = PdfReader(file)
        for page in reader.pages:
            extracted = page.extract_text()
            if extracted:
                text += extracted + "\n"\

    else:
        raise Exception(f"Unsupported file type: {mime_type}")

    keywords_list = keywords(text)
    print("[INFO] Extracted keywords:")
    print(keywords_list)

    return text


@router.get(BASE_PATH+"/health")
def health_check():
    return {"status": "ok"}


@router.get(BASE_PATH+"/")
def root():
    return {"status": "hello"}


@router.post(BASE_PATH+"/upload")
async def upload_file(
    pid: str = Form(..., description="pidr"),
    did: str = Form(..., description="did inside"),
    ver: int = Form(..., description="verMut"),
    file: UploadFile = File(...)):
    time_parse = time.time()
    if not file.filename:
        raise HTTPException(status_code=400, detail="Empty file")

    contents = await file.read()
    await file.seek(0)

    file_extension = os.path.splitext(file.filename)[1].lower()
    mime = magic.from_buffer(contents, mime=True)

    if file_extension in [".docx"] and mime == "text/html":
        mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"

    try:
        text = await parse_file(io.BytesIO(contents), mime)
        data = {
            "pid": pid,
            "did": did,
            "ver": ver,
            "frags": parse_text(text, _split_symbol=" . \n") if file_extension == ".pdf" else parse_text(text, _split_symbol="\n"),
        }

        request = httpx.post("http://core.search:8000/index/document", json=data, timeout=3.0)

        return {
            "pid": pid,
            "did": did,
            "ver": ver,
            "status_request_code": request.status_code,
            "frags": parse_text(text, _split_symbol=" . \n") if file_extension == ".pdf" else parse_text(text, _split_symbol="\n"),
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
