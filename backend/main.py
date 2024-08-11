from fastapi import FastAPI, File, Form, UploadFile, HTTPException, Request
from fastapi.responses import PlainTextResponse
from pydantic import BaseModel
from pathlib import Path
from plum.exceptions import UnpackError
import json
import uuid
import exif

app = FastAPI()

def check_exif(image_data):
    """Check if main exif such as exposure time, aperture, focal length, and ISO are present."""
    image = exif.Image(image_data)
    if not image.has_exif:
        return "无EXIF信息"
    if not "exposure_time" in dir(image):
        return "缺少曝光时间"
    if not "focal_length" in dir(image):
        return "缺少焦距"
    if not "model" in dir(image):
        return "缺少相机型号"
    if not "datetime" in dir(image):
        return "缺少拍摄时间"
    if not "f_number" in dir(image):
        return "缺少光圈"
    return None

def save_result(result, in_dir=Path.home() / 'submit'):
    # Generate a unique UUID
    unique_id = str(uuid.uuid4())

    extension = result['image'][0].split('.')[-1]

    # Prepare the metadata dictionary
    metadata = {
        'name': result['name'],
        'author': result['author'],
        'description': result['description'],
        'school': result['school'],
        'wechat': result['wechat'],
        'email': result['email'],
        'image_filename': f"{unique_id}.{extension}",
        'ip': result['ip'],
    }

    # Save the metadata to a JSON file
    metadata_filename = Path(in_dir) / f"{unique_id}.json"
    metadata_filename.parent.mkdir(exist_ok=True, parents=True)
    with open(metadata_filename, 'w', encoding='utf-8') as json_file:
        json.dump(metadata, json_file, ensure_ascii=False, indent=4)

    # Save the image file with the UUID as its filename
    image_filename = Path(in_dir) / f"{unique_id}.{extension}"
    with open(image_filename, 'wb') as image_file:
        image_file.write(result['image'][1])

    print(f"Saved metadata to {metadata_filename.absolute()}")

    return unique_id

class FormData(BaseModel):
    name: str
    author: str
    school: str
    wechat: str
    email: str
    description: str

@app.post("/upload", response_class=PlainTextResponse)
async def upload_file(
    request: Request,
    name: str = Form(...),
    author: str = Form(...),
    school: str = Form(...),
    wechat: str = Form(...),
    email: str = Form(...),
    description: str = Form(...),
    image: UploadFile = File(...)
):
    if not image.filename:
        raise HTTPException(status_code=400, detail="需要图片")

    image_data = await image.read()
    
    x_forwarded_for = request.headers.get('X-Forwarded-For')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0].strip()
    else:
        ip = request.client.host
    
    result = {
        'image': (image.filename, image_data),
        'name': name,
        'author': author,
        'wechat': wechat,
        'email': email,
        'school': school,
        'description': description,
        'ip': ip,
    }
    try:
        exif_error = check_exif(result['image'][1])
    except UnpackError as e:
        raise HTTPException(status_code=400, detail=f"图片格式错误: {repr(e)}")
    if exif_error:
        raise HTTPException(status_code=400, detail=f"图片缺少exif: {exif_error}")

    save_result(result)
    return "Data received"

@app.get("/")
@app.get("/health")
async def index():
    return {"status": "ok", "version": "1"}
