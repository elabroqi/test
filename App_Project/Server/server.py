from http.server import SimpleHTTPRequestHandler
from socketserver import TCPServer

PORT = 9000

class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory="images", **kwargs)

with TCPServer(("", PORT), Handler) as httpd:
    print(f"Serving images on port {PORT}")
    httpd.serve_forever()

