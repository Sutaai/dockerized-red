#!/usr/bin/env sh
set -eufx

# The 26 error code is used to request a restart
# See https://github.com/Cog-Creators/Red-DiscordBot/blob/30058c0f732ffcf82124bab8781f8b33d1353de4/redbot/core/_cli.py#L16

ARGS=""

if [ -n "${TOKEN:-}" ]; then
  ARGS="${ARGS} --token ${TOKEN}"
fi

if [ -n "${PREFIX:-}" ]; then
  ARGS="${ARGS} --prefix ${PREFIX}"
fi

if [ -n "${MENTIONABLE:-}" ]; then
  ARGS="${ARGS} --mentionable"
fi

if [ -n "${ENABLE_RPC:-}" ]; then
  ARGS="${ARGS} --rpc"
fi

if [ -n "${RPC_PORT:-}" ]; then
  ARGS="${ARGS} --rpc-port ${RPC_PORT:-6133}"
fi

if [ -n "${TEAM_MEMBERS_ARE_OWNERS:-}" ]; then
  ARGS="${ARGS} --team-members-are-owners"
fi

if [ -n "${VERBOSE_LEVEL:-}" ]; then
  if [ "${VERBOSE_LEVEL}" -ge 1 ] && [ "${VERBOSE_LEVEL}" -le 5 ]; then
    ARGS="${ARGS} -$(printf "v%.0s" $(seq 1 "${VERBOSE_LEVEL}"))"
  else
    echo "VERBOSE_LEVEL must be a number from 1 to 5"
    exit 1
  fi
fi

# Credit goes to https://unix.stackexchange.com/a/444676
# And PhasecoreX for pointing this out
prep_term() {
  unset term_child_pid
  unset term_kill_needed
  trap 'handle_term' TERM INT
}

handle_term() {
  if [ -n "${term_child_pid:-}" ]; then
    kill -TERM "${term_child_pid}" 2>/dev/null
  else
    term_kill_needed="yes"
  fi
}

wait_term() {
  term_child_pid=$!
  if [ -n "${term_kill_needed:-}" ]; then
    kill -TERM "${term_child_pid}" 2>/dev/null 
  fi
  wait ${term_child_pid} 2>/dev/null
  trap - TERM INT
  wait ${term_child_pid} 2>/dev/null
}

# Loop logic inspired by https://github.com/PhasecoreX/docker-red-discordbot/blob/8199f6488483e8fd4df91beaca6a0cbbf0d9cb40/root/app/functions/main-loop.sh#L34-L60
# Thank you
# I promise I didn't copy-paste your code. We just happen to be on the very same line.
RETURN_CODE=26
while [ "${RETURN_CODE}" -eq 26 ]; do
  echo "Booting up instance..."
  set +e  # Avoid container exiting if we get any other error code that isn't 0

  # Check if stdin is a terminal
  if [ -t 0 ]; then
    echo "Running in terminal; Do Ctrl+C to exit"
    # shellcheck disable=SC2086
    /data/.venv/bin/python -O -m redbot "${INSTANCE_NAME}" --no-prompt ${ARGS:-} ${RED_ARGS:-}
    RETURN_CODE=$?
  else
    prep_term
    # shellcheck disable=SC2086
    /data/.venv/bin/python -O -m redbot "${INSTANCE_NAME}" --no-prompt ${ARGS:-} ${RED_ARGS:-} &
    wait_term
    RETURN_CODE=$?
  fi

  # That's for whenever they'll fix the AttributeError...
  if [ "${RETURN_CODE}" -eq 78 ]; then
    echo "The configuration of your bot is incomplete. You might have forgot to set the TOKEN or the PREFIX. Please visit the documentation to see how to configure properly your bot."
  fi
done
