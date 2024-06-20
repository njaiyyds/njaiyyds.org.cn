import http.server
import socketserver
import cgi
import json
import uuid
from pathlib import Path
import exif

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

class SimpleHTTPRequestHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-Type", "text/plain")
        self.end_headers()
        self.wfile.write(b"NJAIYYDS")

    def do_OPTIONS(self):
        self.send_response(200, "ok")
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.end_headers()

    def do_POST(self):
        # Parse the form data posted
        content_type = self.headers['content-type']
        if not content_type:
            self.send_error(400, "Content-Type header is missing")
            return

        ctype, pdict = cgi.parse_header(content_type)
        if ctype != 'multipart/form-data':
            self.send_error(400, "Content-Type is not multipart/form-data")
            return

        pdict['boundary'] = bytes(pdict['boundary'], "utf-8")
        pdict['CONTENT-LENGTH'] = int(self.headers['content-length'])
        form = cgi.FieldStorage(
            fp=self.rfile,
            headers=self.headers,
            environ={'REQUEST_METHOD': 'POST'},
            keep_blank_values=True
        )

        # Extracting fields from the form
        image_field = form['image']
        name_field = form['name']
        author_field = form['author']
        school_field = form['school']
        wechat_field = form['wechat']
        email_field = form['email']
        description_field = form['description']

        result = {
            'image': (None, None),
            'name': None,
            'author': None,
            'wechat': None,
            'email': None,
            'school': None,
            'description': None,
            'ip': self.client_address[0],
        }

        if image_field.filename:
            image_data = image_field.file.read()
            result['image'] = (image_field.filename, image_data)
        else:
            self.send_response(400)
            self.end_headers()
            self.wfile.write("需要图片".encode())
            return

        if name_field.value == "":
            self.send_response(400)
            self.end_headers()
            self.wfile.write("需要名字".encode())
            return
        result['name'] = name_field.value

        if author_field.value == "":
            self.send_response(400)
            self.end_headers()
            self.wfile.write("需要作者".encode())
            return
        result['author'] = author_field.value

        if wechat_field.value == "":
            self.send_response(400)
            self.end_headers()
            self.wfile.write("需要微信".encode())
            return
        result['wechat'] = wechat_field.value

        if email_field.value == "":
            self.send_response(400)
            self.end_headers()
            self.wfile.write("需要邮箱".encode())
            return
        result['email'] = email_field.value

        if school_field.value == "":
            self.send_response(400)
            self.end_headers()
            self.wfile.write("需要学校".encode())
            return
        result['school'] = school_field.value

        if description_field.value == "":
            self.send_response(400)
            self.end_headers()
            self.wfile.write("需要描述".encode())
            return
        result['description'] = description_field.value

        exif_error = check_exif(result['image'][1])
        if exif_error:
            self.send_response(400)
            self.end_headers()
            self.wfile.write(f"图片缺少exif: {exif_error}".encode())
            return

        save_result(result)

        # Send a simple HTML response back
        self.send_response(200)
        self.send_header("Content-Type", "text/plain")
        self.end_headers()
        self.wfile.write(b"Data received")

    def end_headers(self):
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Origin", "*")
        http.server.SimpleHTTPRequestHandler.end_headers(self)

PORT = 80  # HTTP port

def main():
    with socketserver.TCPServer(("", PORT), SimpleHTTPRequestHandler) as httpd:
        print("Serving at port", PORT)
        httpd.serve_forever()

if __name__ == "__main__":
    main()
