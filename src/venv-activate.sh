#!/usr/bin/env sh
set -eufx

# Does the venv exist?
if [ ! -d "/data/.venv" ]; then
    python -m venv /data/.venv
fi

# Activate the venv
# shellcheck source=/dev/null
. /data/.venv/bin/activate
pip install -U pip wheel

if ! (pip freeze | grep -q "Red-DiscordBot"); then
    echo "Red is NOT installed"
else
    echo "Red is installed"
fi

# Determine extras
if [ -z "${REDBOT_PACKAGE_EXTRAS:-}" ]; then
    if [ "${STORAGE:-}" = "postgres" ]; then
        REDBOT_INSTALL_EXTRAS="[postgres]"
    else
        REDBOT_INSTALL_EXTRAS=""
    fi
else
    if [ "${STORAGE:-}" = "postgres" ] && ! echo "${REDBOT_PACKAGE_EXTRAS}" | grep -q "postgres"; then
        REDBOT_INSTALL_EXTRAS="[$REDBOT_PACKAGE_EXTRAS,postgres]"
    else
        REDBOT_INSTALL_EXTRAS="[$REDBOT_PACKAGE_EXTRAS]"
    fi
fi

# Determine which package should be installed
if [ -z "${REDBOT_PACKAGE_URL:-}" ]; then
    if [ -z "${REDBOT_VERSION:-}" ]; then
        REDBOT_INSTALL_PKG="red-discordbot${REDBOT_INSTALL_EXTRAS}"
    else
        REDBOT_INSTALL_PKG="red-discordbot${REDBOT_INSTALL_EXTRAS}==${REDBOT_VERSION}"
    fi
else
    REDBOT_INSTALL_PKG="${REDBOT_PACKAGE_URL}${REDBOT_INSTALL_EXTRAS}"
fi

# Install Redbot
PIP_UPGRADE=${PIP_UPGRADE:+true}
pip install "${REDBOT_INSTALL_PKG}"
