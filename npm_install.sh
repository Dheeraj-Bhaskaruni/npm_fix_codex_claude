#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# OpenAI Codex CLI install script (Ubuntu) — from scratch
# - Installs Node.js LTS (via NodeSource, includes npm)
# - Sets a user-writable npm global prefix (no sudo npm -g)
# - Installs @openai/codex globally
# - Works for bash or zsh
# ============================================================

NODE_MAJOR="${NODE_MAJOR:-20}"   # change to 18 if you really need it
NPM_PREFIX_DIR="${NPM_PREFIX_DIR:-$HOME/.npm-global}"

echo "==> Updating apt + installing prerequisites..."
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg

echo "==> Installing Node.js LTS (NodeSource ${NODE_MAJOR}.x)..."
# Add NodeSource repo
curl -fsSL "https://deb.nodesource.com/setup_${NODE_MAJOR}.x" | sudo -E bash -
sudo apt-get install -y nodejs

echo "==> Verifying node + npm..."
node -v
npm -v

echo "==> Configuring npm global prefix (user-writable): ${NPM_PREFIX_DIR}"
mkdir -p "${NPM_PREFIX_DIR}"
npm config set prefix "${NPM_PREFIX_DIR}"

# Determine shell rc file
SHELL_NAME="$(basename "${SHELL:-bash}")"
RC_FILE="$HOME/.bashrc"
if [[ "${SHELL_NAME}" == "zsh" ]]; then
  RC_FILE="$HOME/.zshrc"
fi

EXPORT_LINE='export PATH="$HOME/.npm-global/bin:$PATH"'

echo "==> Ensuring PATH is set in ${RC_FILE} ..."
if ! grep -Fxq "${EXPORT_LINE}" "${RC_FILE}" 2>/dev/null; then
  echo "" >> "${RC_FILE}"
  echo "# Added by codex install script" >> "${RC_FILE}"
  echo "${EXPORT_LINE}" >> "${RC_FILE}"
fi

# Apply PATH for this current session too
export PATH="$HOME/.npm-global/bin:$PATH"

echo "==> Installing OpenAI Codex CLI (@openai/codex)..."
npm i -g @openai/codex

echo "==> Checking installation..."
command -v codex >/dev/null 2>&1 || {
  echo "ERROR: codex not found on PATH."
  echo "Try: source ${RC_FILE}  (or open a new terminal)"
  exit 1
}

echo "==> Done"
echo "node:  $(node -v)"
echo "npm:   $(npm -v)"
echo "codex: $(codex --version || true)"
echo ""
echo "If 'codex' isn't found in a NEW terminal, run:"
echo "  source ${RC_FILE}"