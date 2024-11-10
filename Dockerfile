ARG PYTHON_VERSION=3.11
FROM python:${PYTHON_VERSION}-slim-bookworm AS base

# DR: Dockerized Red
ARG DR_TAG_VERSION

# User arguments
ARG APT_INSTALL

ENV DEBIAN_FRONTEND=noninteractive
RUN set -eux; \
  apt update -y

# Required deps
RUN set -eux; \
  apt install -y --no-install-recommends \
    build-essential git jq ssh

# Additional deps set by user
RUN set -eux; \
  if [ -n "${APT_INSTALL:-}" ]; then \
    apt install -y --no-install-recommends ${APT_INSTALL}; \
  fi

VOLUME [ "/data" ]

# Link config.json
RUN mkdir /data && touch /data/config.json && \
  mkdir -p /root/.config/Red-DiscordBot && \
  ln -s /data/config.json /root/.config/Red-DiscordBot/config.json

# Copy scripts
COPY src/ /usr/src/dockerized-red
RUN chmod +x /usr/src/dockerized-red/*.sh

CMD [ "/usr/src/dockerized-red/entrypoint.sh" ]
