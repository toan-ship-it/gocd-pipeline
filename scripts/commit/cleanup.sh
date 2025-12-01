#!/bin/bash
set -e

IMAGE_NAME="${DOCKERHUB_USERNAME}/${APP_NAME}"

echo "=== Removing all local images for $IMAGE_NAME ==="

# Lấy toàn bộ image ID của repo đó
IMAGE_IDS=$(docker images | grep "$IMAGE_NAME" | awk '{print $3}' | sort -u)

for ID in $IMAGE_IDS; do
  echo "Deleting image ID: $ID"
  docker rmi -f $ID || true
done

echo "=== All images removed ==="
