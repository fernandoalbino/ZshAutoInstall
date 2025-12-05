#!/usr/bin/env bash
set -e

REPO_URL="${REPO_URL:-https://github.com/fernandoalbino/dotfiles-public.git}"
TARGET_DIR="${TARGET_DIR:-$HOME/.dotfiles-public}"

echo "Clonando (ou atualizando) repositório em: $TARGET_DIR"

if [ -d "$TARGET_DIR/.git" ]; then
  git -C "$TARGET_DIR" pull --rebase
else
  git clone "$REPO_URL" "$TARGET_DIR"
fi

bash "$TARGET_DIR/scripts/install_full.sh"
