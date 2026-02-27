#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install uv if not found
if ! command -v uv &>/dev/null; then
    echo "uv not found, installing..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

cd "$SCRIPT_DIR"

# Init project if pyproject.toml or uv.lock are missing
if [ ! -f "pyproject.toml" ] || [ ! -f "uv.lock" ]; then
    echo "Initializing uv project..."
    uv init --no-workspace
fi

# Install dependencies
echo "Installing dependencies..."
uv pip install -r requirements.txt --python .venv/bin/python 2>/dev/null \
    || uv sync

echo "Setup complete."
