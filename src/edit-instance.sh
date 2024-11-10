#!/usr/bin/env sh
set -euf

if [ -n "${EDIT_TOKEN:-}" ]; then
  python -0 -m redbot "${INSTANCE_NAME}" --no-prompt --edit --token "${EDIT_TOKEN}"
  echo "Token edited"
fi

if [ -n "${EDIT_PREFIX:-}" ]; then
  python -0 -m redbot "${INSTANCE_NAME}" --no-prompt --edit --prefix "${EDIT_PREFIX}"
  echo "Prefix edited"
fi

if [ -n "${EDIT_OWNER:-}" ]; then
  python -0 -m redbot "${INSTANCE_NAME}" --no-prompt --edit --owner "${EDIT_OWNER}"
  echo "Owner edited"
fi
