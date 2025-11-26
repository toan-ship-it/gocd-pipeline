#!/bin/bash
set -e

# --- Check arguments ---
if [ $# -ne 4 ]; then
    echo "Usage: $0 <pipeline_counter> <revision> <docker_username> <app_name>"
    exit 1
fi

REVISION=$2
USERNAME=$3
APP_NAME=$4

# --- Compute Docker tag ---
TAG="${REVISION}"

echo "Git revision: $REVISION"
echo "Docker username: $USERNAME"
echo "App name: $APP_NAME"
echo "Docker image tag: $TAG"

# --- Build Docker image ---
docker build -t "${USERNAME}/${APP_NAME}:${TAG}" -t "${USERNAME}/${APP_NAME}:latest" .

