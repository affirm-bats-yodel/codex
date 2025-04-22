#!/bin/bash
set -euo pipefail

TARGET_DIR="$1"

# Check $WORKSPACE_DIRECTORY exists and execute command to
# chown $WORKSPACE_DIRECTORY to 1000:1000 (node:node)
if [ -d "${TARGET_DIR}" ]; then
  echo "execute: chown -R 1000:1000 ${TARGET_DIR}"
  chown -R node:node ${TARGET_DIR}
else
  echo "Directory does not exist: ${TARGET_DIR}" >&2
  exit 1
fi