#!/bin/bash
set -euo pipefail

# Check $WORKSPACE_DIRECTORY exists and execute command to
# chown $WORKSPACE_DIRECTORY to 1000:1000 (node:node)
if [ -d "${WORKSPACE_DIRECTORY}" ]; then
  echo "execute: chown -R 1000:1000 ${WORKSPACE_DIRECTORY}"
  chown -R node:node ${WORKSPACE_DIRECTORY}
fi