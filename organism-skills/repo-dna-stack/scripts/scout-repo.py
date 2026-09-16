#!/usr/bin/env python3
"""Scout one GitHub repo via REST. No clone. Prefer this over jq on hosts without jq."""
import json, os, sys, urllib.request
from datetime import datetime, timezone

def get(url, token):
    req = urllib.request.Request(url, headers={
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
        "User-Agent": "the-one-repo-dna-scout",
    })
    if token:
        req.add_header("Authorization", f"Bearer {token}")
    with urllib.request.urlopen(req, timeout=30) as res:
        return json.loads(res.read().decode())

def main():
    if len(sys.argv) < 3:
        print("Usage: scout-repo.py <owner> <repo> [branch]", file=sys.stderr)
        sys.exit(1)
    owner, repo = sys.argv[1], sys.argv[2]
    branch = sys.argv[3] if len(sys.argv) > 3 else None
    token = os.environ.get("GITHUB_TOKEN", "")
    api = f"https://api.github.com/repos/{owner}/{repo}"
    try:
        meta = get(api, token)
    except Exception as e:
        print(json.dumps({"owner": owner, "repo": repo, "scout_status": "error", "gaps": [str(e)]}))
        sys.exit(1)
    if meta.get("message"):
        print(json.dumps({"owner": owner, "repo": repo, "scout_status": "error", "gaps": [meta["message"]]}))
        sys.exit(1)
    branch = branch or meta.get("default_branch") or "main"
    try:
        root = get(f"{api}/contents?ref={branch}", token)
    except Exception:
        root = []
    files = [{"name": i.get("name"), "type": i.get("type")} for i in root] if isinstance(root, list) else []
    out = {
        "owner": owner,
        "repo": repo,
        "scanned_branch": branch,
        "default_branch": meta.get("default_branch"),
        "url": meta.get("html_url"),
        "description": meta.get("description"),
        "language": meta.get("language"),
        "pushed_at": meta.get("pushed_at"),
        "private": meta.get("private"),
        "file_inventory": {"root_files": files},
        "evidence": [
            f"GET /repos/{owner}/{repo}",
            f"GET /repos/{owner}/{repo}/contents?ref={branch}",
        ],
        "timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "scout_status": "success" if files else "partial",
    }
    print(json.dumps(out, indent=2))

if __name__ == "__main__":
    main()
