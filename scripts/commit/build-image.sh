#!/bin/bash
set -e

# --- Check arguments ---
if [ $# -ne 4 ]; then
    echo "Usage: $0 <build_pipeline_count> <revision> <docker_username> <app_name>"
    exit 1
fi

BUILD_COUNT=$1
REVISION=$2
USERNAME=$3
APP_NAME=$4

# --- Compute Docker tag ---
TAG="${BUILD_COUNT}-${REVISION}"

echo "Build count: $BUILD_COUNT"
echo "Git revision: $REVISION"
echo "Docker username: $USERNAME"
echo "App name: $APP_NAME"
echo "Docker image tag: $TAG"

# --- Build Docker image ---
docker build -t "${USERNAME}/${APP_NAME}:${TAG}" -t "${USERNAME}/${APP_NAME}:latest" .

