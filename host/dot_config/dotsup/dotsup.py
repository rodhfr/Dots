#!/usr/bin/env python3

import subprocess
import sys
import shutil
import os
from pathlib import Path
import argparse

# ── Minimal config parser ─────────────────────────────────────


def load_simple_config(path: Path) -> dict:
    data = {}
    current_list = None

    with path.open() as f:
        for lineno, raw in enumerate(f, 1):
            line = raw.strip()

            if not line or line.startswith("#"):
                continue

            if line.startswith("- "):
                if current_list is None:
                    raise ValueError(f"Line {lineno}: list item without a key")
                current_list.append(line[2:])
                continue

            if ":" in line:
                key, value = line.split(":", 1)
                key = key.strip()
                value = value.strip()

                if not key:
                    raise ValueError(f"Line {lineno}: empty key")

                if value == "":
                    data[key] = []
                    current_list = data[key]
                else:
                    data[key] = value
                    current_list = None
                continue

            raise ValueError(f"Line {lineno}: cannot parse '{line}'")

    return data


# ── Helpers ──────────────────────────────────────────────────


def echo(msg: str) -> None:
    print(msg, flush=True)


def copy_dir(src: Path, dst: Path) -> None:
    if not src.exists():
        echo(f"Source not found: {src}")
        sys.exit(1)

    dst.mkdir(parents=True, exist_ok=True)

    for item in src.iterdir():
        target = dst / item.name
        if item.is_dir():
            shutil.copytree(item, target, dirs_exist_ok=True)
        else:
            shutil.copy2(item, target)


# ── Argument parsing ─────────────────────────────────────────

parser = argparse.ArgumentParser(description="Sync dotfiles and commit changes.")
parser.add_argument("-c", "--commit", type=str, help="Custom commit message")
args = parser.parse_args()

# ── Main ─────────────────────────────────────────────────────

config_path = Path("dotsup.conf")
if not config_path.exists():
    echo("Config file dotsup.conf not found")
    sys.exit(1)

try:
    cfg = load_simple_config(config_path)
except ValueError as e:
    echo(f"Config error: {e}")
    sys.exit(1)

try:
    dots_repo = Path(cfg["repo_path"])
    source_root = Path(cfg["source_root"])
    configs = cfg["configs"]
    commit_msg = cfg.get("commit_message", "Update dotfiles")
except KeyError as e:
    echo(f"Missing config key: {e}")
    sys.exit(1)

# Override commit message if -c flag is used
if args.commit:
    commit_msg = args.commit

dest_root = dots_repo

echo("Starting dotfiles sync process...")

for name in configs:
    echo(f"Copying {name} configuration...")
    copy_dir(source_root / name, dest_root / name)
    echo(f"{name} configuration copied.")

echo("Changing directory to Dots repository...")
os.chdir(dots_repo)

echo("Staging dot_config...")
subprocess.run(["git", "add", "."], check=True)

diff = subprocess.run(["git", "diff", "--cached", "--quiet"])
if diff.returncode == 0:
    echo("No changes detected. Nothing to commit or push.")
    sys.exit(0)

echo(f"Committing changes with message: '{commit_msg}'")
subprocess.run(["git", "commit", "-m", commit_msg], check=True)

echo("Pushing to remote repository...")
subprocess.run(["git", "push"], check=True)

echo("Dotfiles synced, committed, and pushed successfully.")
