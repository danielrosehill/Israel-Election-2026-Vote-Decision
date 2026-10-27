"""Publish space/ to the public HF Space danielrosehill/Israel-Election-2026-AI-Vote-Decision.
Usage: with-secrets uv run --with huggingface_hub python3 -I scripts/publish_space.py  (from repo root)"""
import os
from huggingface_hub import HfApi

REPO = "danielrosehill/Israel-Election-2026-AI-Vote-Decision"
tok = os.environ.get("HF_TOKEN") or os.environ.get("HUGGINGFACE_TOKEN") or os.environ.get("HF_API_TOKEN")
api = HfApi(token=tok)
api.create_repo(REPO, repo_type="space", space_sdk="static", private=False, exist_ok=True)
api.upload_folder(folder_path="space", repo_id=REPO, repo_type="space", commit_message="Publish vote-decision experiment")
print(f"https://huggingface.co/spaces/{REPO}")
