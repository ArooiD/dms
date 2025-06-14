import time

from fastapi import APIRouter, UploadFile, File, HTTPException
import magic
import io

import re
from collections import Counter
from docx import Document
from PyPDF2 import PdfReader

router = APIRouter()
BASE_PATH = "/analyze"
STOP = set("""и в не на с к по для от что это как он она они из у о""".split())


def keywords(text, k=10):
    words = re.findall(r"[А-Яа-яA-Za-z]{4,}", text.lower())
    common = (w for w in words if w not in STOP)
    most = Counter(common).most_common(k)
    return [w for w, _ in most]


async def parse_file(file: UploadFile, mime_type: str):
    print(f"[INFO] Parsing file: {file.filename}")
    print(f"[INFO] MIME type: {mime_type}")

    contents = await file.read()
    text = ""

    if mime_type == "text/plain":
        text = contents.decode("utf-8")

    elif mime_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
        f = io.BytesIO(contents)
        doc = Document(f)
        text = "\n".join(paragraph.text for paragraph in doc.paragraphs)

    elif mime_type == "application/pdf":
        f = io.BytesIO(contents)
        reader = PdfReader(f)
        for page in reader.pages:
            extracted = page.extract_text()
            if extracted:
                text += extracted + "\n"

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
async def upload_file(file: UploadFile = File(...)):
    time_parse = time.time()
    if not file.filename:
        raise HTTPException(status_code=400, detail="Empty file")

    mime = magic.from_buffer(await file.read(2048), mime=True)
    await file.seek(0)

    try:
        text = await parse_file(file, mime)
        return {
            "message": "File parsed successfully (no disk saved)",
            "filename": file.filename,
            "mime_type": mime,
            "time_parse": time.time() - time_parse,
            "text_lvl2": parse_text(text, _split_symbol=" . \n"),
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
            array.append(line.strip().replace("\n", "") + ".")
    return array


def is_empty(line: str):
    return not line or line.strip() == ""
