#!/bin/bash
set -e

# --- Check arguments ---
if [ $# -ne 3 ]; then
    echo "Usage: $0 <revision> <docker_username> <app_name>"
    exit 1
fi

REVISION=$1
USERNAME=$2
APP_NAME=$3

# --- Compute Docker tag ---
TAG="${REVISION}"

echo "Git revision: $REVISION"
echo "Docker username: $USERNAME"
echo "App name: $APP_NAME"
echo "Docker image tag: $TAG"

# --- Build Docker image ---
docker build -t "${USERNAME}/${APP_NAME}:${TAG}" -t "${USERNAME}/${APP_NAME}:latest" .

