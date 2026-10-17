#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="${SCRIPT_DIR}/mpv.conf"
CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/mpv"
TARGET="${CONFIG_DIR}/mpv.conf"

mkdir -p -- "$CONFIG_DIR"

if [[ -e "$TARGET" || -L "$TARGET" ]]; then
  if [[ -L "$TARGET" && "$(readlink -- "$TARGET")" == "$SOURCE" ]]; then
    echo "mpv config is already linked to $SOURCE"
    exit 0
  fi

  echo "Refusing to overwrite existing file: $TARGET" >&2
  echo "Move it aside, then run this script again." >&2
  exit 1
fi

ln -s -- "$SOURCE" "$TARGET"
echo "Linked $TARGET to $SOURCE"
