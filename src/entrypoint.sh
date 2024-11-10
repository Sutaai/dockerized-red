#!/usr/bin/env sh
set -eufx

export INSTANCE_NAME="${INSTANCE_NAME:-bot}"

# Add SSH key to agent, if it exists.
if [ -f /run/secrets/ssh-key ]; then
    echo "Adding SSH key to agent"
    eval "$(ssh-agent -s)"
    ssh-add /run/secrets/ssh-key
fi

# Create (If required) and enable the virtual environnement, also download dependencies
# shellcheck source=venv-activate.sh
. /usr/src/dockerized-red/venv-activate.sh

# Create an instance if required
# shellcheck source=create-instance.sh
. /usr/src/dockerized-red/create-instance.sh
# Edit the instance if required
# shellcheck source=edit-instance.sh
. /usr/src/dockerized-red/edit-instance.sh

# Launch the instance
# shellcheck source=launch-instance.sh
. /usr/src/dockerized-red/launch-instance.sh