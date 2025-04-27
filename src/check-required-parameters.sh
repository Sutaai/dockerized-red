#!/usr/bin/env sh
set -euf

# Enable debug mode
if [ -n "${SCRIPT_DEBUG:-}" ]; then
  set -x
fi

RED='\033[0;31m'
RESET='\033[0m'

if [ -z "${STORAGE:-}" ]; then
  echo "Please set the STORAGE environment variable to the bot's token. Refer to documentation for details."
  exit 1
fi

if [ -z "${TOKEN:-}" ]; then
  echo -e "${RED}It appears you haven't set a token through the \"TOKEN\" environment variable.${RESET} You should prefer using it instead of \"EDIT_TOKEN\" if this is your case. ${RED}Be sure to have set your token somewhere anyhow.${RESET}"
fi
if [ -z "${PREFIX:-}" ]; then
  echo -e "${RED}It appears you haven't set a token through the \"PREFIX\" environment variable (Which is a hard requirement for Red-DiscordBot).${RESET} You should prefer using it instead of \"EDIT_PREFIX\" if this is your case. ${RED}Be sure to have set your prefix somewhere anyhow.${RESET}"
fi

if [ "${STORAGE:-}" = "postgres" ] && [ -z "${PSQL_HOST:-}" ]; then
  echo "The PSQL_HOST is mandatory if you set STORAGE to postgres. Please set the host accordingly. Refer to documentation for details."
  exit 1
fi
