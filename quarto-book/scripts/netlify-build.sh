#!/usr/bin/env bash
set -euo pipefail

QUARTO_INSTALL_DIR="${HOME}/quarto"

LATEST_RELEASE_JSON_URL="https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest"

TARBALL_URL="$(
  curl -fsSL "${LATEST_RELEASE_JSON_URL}" \
    | grep -Eo 'https://[^"]+quarto-[^"]+-linux-amd64\\.tar\\.gz' \
    | head -n 1
)"

if [[ -z "${TARBALL_URL}" ]]; then
  echo "Unable to find Quarto linux-amd64 tarball URL from ${LATEST_RELEASE_JSON_URL}" >&2
  exit 1
fi

curl -fsSL -L -o quarto.tar.gz "${TARBALL_URL}"

mkdir -p "${QUARTO_INSTALL_DIR}"
tar -xzf quarto.tar.gz -C "${QUARTO_INSTALL_DIR}" --strip-components=1
export PATH="${QUARTO_INSTALL_DIR}/bin:${PATH}"

quarto --version
quarto render
