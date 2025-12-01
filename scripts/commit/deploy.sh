#!/bin/bash
set -e

# --- Variables from GoCD environment ---
HELM_CHART_DIR="../pipeline/helm-chart/${APP_NAME}" # path đến chart
BUILD_COUNT=${GO_DEPENDENCY_LABEL_BUILDTESTREPORT}
REVISION=${GO_REVISION_GIT_46F3484}
DB_HOST="172.19.93.189"
DB_PORT="27017"

# --- Compute image tag ---
IMAGE_TAG="${BUILD_COUNT}-${REVISION}"
echo "Using image tag: ${IMAGE_TAG}"

# --- Release and namespace ---
RELEASE_NAME="preview-deploy"
NAMESPACE="preview-deploy"

echo "Release: ${RELEASE_NAME}"
echo "Namespace: ${NAMESPACE}"

# --- Values files ---
# VALUES_ARGS="-f ${HELM_CHART_DIR}/values/values.yaml -f ${HELM_CHART_DIR}/ingress-values.yaml"

# --- Helm upgrade/install ---
helm upgrade --install "${RELEASE_NAME}" "${HELM_CHART_DIR}" \
  -n "${NAMESPACE}" --create-namespace \
  --set mongo.uri="mongodb://${DB_HOST}:${DB_PORT}" \
  --set image.tag="${IMAGE_TAG}" \
  --set image.repository="${DOCKERHUB_USERNAME}/${APP_NAME}"

echo "Deployment completed with tag: ${IMAGE_TAG}"

