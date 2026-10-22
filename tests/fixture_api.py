#!/usr/bin/env python3
"""Tiny offline stand-in for the GitHub REST API, used only by tests.

Serves fixed answers for two fake repositories so the orchestrator's output
can be checked against known truth. Anything else returns 404, like GitHub.
Usage: fixture_api.py <port-file>   (writes the chosen port, then serves)
"""
import base64
import json
import sys
from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse

SHA_NODE = "a" * 40
SHA_PY = "b" * 40


def b64(text):
    return base64.b64encode(text.encode()).decode()


PKG = json.dumps({
    "name": "node-app",
    "dependencies": {"express": "^4.21.0", "lodash": "^4.17.21"},
    "devDependencies": {"vite": "^5.4.0"},
})
README_NODE = "# node-app\n## Overview\n## Installation\n## Usage\n## Testing\n"

ROUTES = {
    "/repos/fixture/node-app/commits/main": {"sha": SHA_NODE},
    "/repos/fixture/node-app/contents": [
        {"name": "package.json", "type": "file", "path": "package.json"},
        {"name": "yarn.lock", "type": "file", "path": "yarn.lock"},
        {"name": "README.md", "type": "file", "path": "README.md"},
        {"name": "src", "type": "dir", "path": "src"},
    ],
    "/repos/fixture/node-app/languages": {"TypeScript": 9000, "JavaScript": 1000},
    "/repos/fixture/node-app/contents/package.json": {"path": "package.json", "content": b64(PKG)},
    "/repos/fixture/node-app/contents/README.md": {"path": "README.md", "content": b64(README_NODE)},
    "/repos/fixture/node-app": {"description": "fixture node app"},

    "/repos/fixture/py-tool/commits/main": {"sha": SHA_PY},
    "/repos/fixture/py-tool/contents": [
        {"name": "pyproject.toml", "type": "file", "path": "pyproject.toml"},
        {"name": "tool.py", "type": "file", "path": "tool.py"},
    ],
    "/repos/fixture/py-tool/languages": {"Python": 5000},
    "/repos/fixture/py-tool/contents/pyproject.toml": {"path": "pyproject.toml", "content": b64("[project]\nname='t'\n")},
    "/repos/fixture/py-tool": {"description": "fixture python tool"},
}


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        path = urlparse(self.path).path.rstrip("/")
        body = ROUTES.get(path)
        code = 200 if body is not None else 404
        if body is None:
            body = {"message": "Not Found"}
        data = json.dumps(body).encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def log_message(self, *args):
        pass


if __name__ == "__main__":
    server = HTTPServer(("127.0.0.1", 0), Handler)
    with open(sys.argv[1], "w") as f:
        f.write(str(server.server_address[1]))
    server.serve_forever()
