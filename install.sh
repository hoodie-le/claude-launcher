#!/usr/bin/env bash
# claude-launcher installer — for users who don't want Homebrew.
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/hoodie-le/claude-launcher/main/install.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/hoodie-le/claude-launcher/main/install.sh | PREFIX=$HOME/.local bash

set -euo pipefail

REPO="hoodie-le/claude-launcher"
PREFIX="${PREFIX:-/usr/local}"
BIN_DIR="$PREFIX/bin"
SCRIPT_NAME="claude-launcher"

err() { printf '\033[0;31m✗ %s\033[0m\n' "$*" >&2; }
ok()  { printf '\033[0;32m✓ %s\033[0m\n' "$*"; }
info(){ printf '\033[0;34m→ %s\033[0m\n' "$*"; }

if [[ "$(uname -s)" != "Darwin" ]]; then
    err "claude-launcher supports macOS only."
    exit 1
fi

info "Fetching latest release of $REPO..."
LATEST_URL=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
    | grep -E '"tarball_url"' | head -1 | cut -d '"' -f 4)
if [[ -z "$LATEST_URL" ]]; then
    err "Could not determine latest release. Falling back to main branch."
    LATEST_URL="https://github.com/$REPO/archive/refs/heads/main.tar.gz"
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

info "Downloading..."
curl -fsSL "$LATEST_URL" | tar xz -C "$TMP" --strip-components=1

if [[ ! -f "$TMP/bin/$SCRIPT_NAME" ]]; then
    err "Downloaded archive does not contain bin/$SCRIPT_NAME."
    exit 1
fi

info "Installing to $BIN_DIR..."
if [[ ! -d "$BIN_DIR" ]]; then
    mkdir -p "$BIN_DIR" 2>/dev/null || sudo mkdir -p "$BIN_DIR"
fi

if [[ -w "$BIN_DIR" ]]; then
    install -m 0755 "$TMP/bin/$SCRIPT_NAME" "$BIN_DIR/$SCRIPT_NAME"
else
    sudo install -m 0755 "$TMP/bin/$SCRIPT_NAME" "$BIN_DIR/$SCRIPT_NAME"
fi

ok "Installed → $BIN_DIR/$SCRIPT_NAME"
info "Run: $SCRIPT_NAME --help"
