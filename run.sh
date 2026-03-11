#!/bin/bash
set -euo pipefail

export UID=$(id -u)
export GID=$(id -g)

docker compose run --rm benchmark "$@"
