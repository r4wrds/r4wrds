#!/usr/bin/env bash
set -euo pipefail

QUARTO_INSTALL_DIR="${HOME}/quarto"

curl -fsSL \
  -o quarto.tar.gz \
  "https://github.com/quarto-dev/quarto-cli/releases/latest/download/quarto-linux-amd64.tar.gz"

mkdir -p "${QUARTO_INSTALL_DIR}"
tar -xzf quarto.tar.gz -C "${QUARTO_INSTALL_DIR}" --strip-components=1
export PATH="${QUARTO_INSTALL_DIR}/bin:${PATH}"

quarto --version
quarto render
