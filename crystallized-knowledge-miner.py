#!/usr/bin/env python3
"""Skill 41 — Crystallized Knowledge Miner.

Read a DNA extract directory. Write output/09_crystals.json.
Never promotes to Brain. Never POSTs harvest ingest. No network.
"""

from __future__ import annotations

import hashlib
import json
import sys
from datetime import datetime, timezone
from pathlib import Path

SCHEMA = "crystal.1.0.0"
NOISE_PREFIXES = ("public/__grok/", "public/__grok")


def load(path: Path) -> dict | None:
    if not path.is_file():
        return None
    return json.loads(path.read_text(encoding="utf-8"))


def cid(owner: str, repo: str, kind: str, title: str) -> str:
    raw = f"{owner}/{repo}/{kind}/{title}".encode()
    return "c_" + hashlib.sha256(raw).hexdigest()[:12]


def crystal(owner: str, repo: str, kind: str, title: str, body: str, evidence: list, confidence: float) -> dict:
    return {
        "id": cid(owner, repo, kind, title),
        "kind": kind,
        "title": title,
        "body": body,
        "evidence": evidence,
        "confidence": round(confidence, 2),
    }


def is_noise_path(p: str) -> bool:
    return p.startswith(NOISE_PREFIXES) or "/__grok/" in p


def mine(extract_dir: Path) -> dict:
    output = extract_dir / "output"
    dna = load(output / "02_repo_dna.json")
    forensic = load(output / "03.5_forensic_report.json")
    if not dna or not forensic:
        raise SystemExit(f"need 02_repo_dna.json and 03.5_forensic_report.json under {output}")

    meta = dna.get("metadata") or {}
    owner = meta.get("owner") or (forensic.get("metadata") or {}).get("owner") or "unknown"
    repo = meta.get("repo") or (forensic.get("metadata") or {}).get("repo") or extract_dir.name
    ident = forensic.get("1_system_identity") or {}
    info = dna.get("project_info") or {}
    stack = dna.get("tech_stack") or {}
    missing = forensic.get("19_what_is_missing") or {}
    path_steps = forensic.get("20_critical_path") or []
    verdict = forensic.get("23_executive_verdict") or {}

    crystals: list[dict] = []
    noise_n = 0

    # IDENTITY
    purpose = ident.get("actual_purpose") or info.get("purpose") or "GAP"
    paradigm = ident.get("architectural_paradigm") or "GAP"
    desc = (info.get("description") or ident.get("apparent_purpose") or "").strip()
    crystals.append(
        crystal(
            owner, repo, "IDENTITY",
            f"{owner}/{repo}",
            f"{paradigm} {purpose}. {desc}".strip(),
            ["03.5_forensic_report.json#1_system_identity", "02_repo_dna.json#project_info"],
            float(meta.get("confidence") or forensic.get("metadata", {}).get("confidence_level") or 0.5),
        )
    )

    # STACK — primary language + runtime + paradigm. Not every package.
    langs = [x.get("name") for x in (stack.get("languages") or []) if x.get("primary")]
    if not langs:
        langs = [x.get("name") for x in (stack.get("languages") or []) if x.get("name")]
    runtime = (stack.get("runtime") or {}).get("type") or ident.get("runtime_environment") or "GAP"
    crystals.append(
        crystal(
            owner, repo, "STACK",
            "declared stack",
            f"languages={', '.join(langs) or 'GAP'}; runtime={runtime}; paradigm={paradigm}",
            ["02_repo_dna.json#tech_stack", "03.5_forensic_report.json#1_system_identity"],
            0.8 if langs else 0.4,
        )
    )

    # LAW — fail-closed path only
    for step in path_steps:
        action = (step.get("action") or "").strip()
        if not action:
            continue
        crystals.append(
            crystal(
                owner, repo, "LAW",
                f"path step {step.get('step')}",
                f"{action} → {step.get('outcome') or 'GAP'}",
                ["03.5_forensic_report.json#20_critical_path"],
                0.9,
            )
        )

    # GAP — P0/P1 only
    for item in (missing.get("p0_blocking") or []) + (missing.get("p1_critical") or []):
        if not item:
            continue
        crystals.append(
            crystal(
                owner, repo, "GAP",
                "missing",
                str(item),
                ["03.5_forensic_report.json#19_what_is_missing"],
                0.85,
            )
        )

    # VERDICT
    what = verdict.get("what_this_system_really_is") or "GAP"
    maturity = verdict.get("final_maturity_score")
    commercial = verdict.get("commercial_potential") or "UNKNOWN"
    crystals.append(
        crystal(
            owner, repo, "VERDICT",
            "executive verdict",
            f"{what} maturity={maturity if maturity is not None else 'GAP'} commercial={commercial}",
            ["03.5_forensic_report.json#23_executive_verdict"],
            0.7,
        )
    )

    # NOISE — platform chrome listed as valuable
    assets = verdict.get("most_valuable_assets") or []
    noisy = [a for a in assets if isinstance(a, str) and is_noise_path(a)]
    if noisy:
        noise_n = len(noisy)
        crystals.append(
            crystal(
                owner, repo, "NOISE",
                "chrome listed as valuable",
                f"{noise_n} paths under public/__grok were scored as assets. Platform chrome is not product knowledge.",
                ["03.5_forensic_report.json#23_executive_verdict.most_valuable_assets"],
                0.9,
            )
        )

    return {
        "schema": SCHEMA,
        "promote_to_brain": False,
        "harvest_ingest": False,
        "mined_at": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "source": {
            "owner": owner,
            "repo": repo,
            "dna_schema": meta.get("schema_version") or "1.1.0",
            "evidence_paths": ["02_repo_dna.json", "03.5_forensic_report.json"],
        },
        "counts": {"crystals": len(crystals), "noise_flagged": noise_n},
        "crystals": crystals,
    }


def main() -> None:
    if len(sys.argv) != 2:
        print("Usage: python3 crystallized-knowledge-miner.py <extract-dir>", file=sys.stderr)
        sys.exit(2)
    extract_dir = Path(sys.argv[1]).resolve()
    out = mine(extract_dir)
    dest = extract_dir / "output" / "09_crystals.json"
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_text(json.dumps(out, indent=2) + "\n", encoding="utf-8")
    print(f"wrote {dest} crystals={out['counts']['crystals']} promote_to_brain=false")


if __name__ == "__main__":
    main()
