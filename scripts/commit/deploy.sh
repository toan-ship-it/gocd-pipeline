#!/bin/bash
set -e

# --- Variables from GoCD environment ---
HELM_CHART_DIR="./helm-chart/${APP_NAME}"   # path đến chart
REVISION=${GO_REVISION_GIT_46F3484}

# --- Compute image tag ---
IMAGE_TAG="${REVISION}"
echo "Using image tag: ${IMAGE_TAG}"

# --- Release and namespace ---
RELEASE_NAME="preview-deploy-${REVISION}"
NAMESPACE="preview-deploy-${REVISION}"

echo "Release: ${RELEASE_NAME}"
echo "Namespace: ${NAMESPACE}"

# --- Values files ---
# VALUES_ARGS="-f ${HELM_CHART_DIR}/values/values.yaml -f ${HELM_CHART_DIR}/ingress-values.yaml"

# --- Helm upgrade/install ---
helm upgrade --install "${RELEASE_NAME}" "${HELM_CHART_DIR}" \
  -n "${NAMESPACE}" --create-namespace \
#  ${VALUES_ARGS} \
  --set image.tag="${IMAGE_TAG}" \
  --set image.repository="${DOCKERHUB_USERNAME}/${APP_NAME}"

echo "Deployment completed with tag: ${IMAGE_TAG}"

