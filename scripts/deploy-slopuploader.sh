#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

if [[ $EUID -ne 0 ]]; then
  echo "Run with sudo: sudo $0" >&2
  exit 1
fi

export HOME=/root
export SOPS_AGE_KEY_FILE="/root/sops-age-key.txt"

extract() {
  sops -d --extract "[\"slopuploader\"][\"$1\"]" secrets/secrets.yaml
}

echo "==> Recreating slopuploader-secrets"
kubectl delete secret slopuploader-secrets --ignore-not-found
kubectl create secret generic slopuploader-secrets \
  --from-literal=admin-token="$(extract admin_token)" \
  --from-literal=s3-access-key="$(extract s3_access_key)" \
  --from-literal=s3-secret-key="$(extract s3_secret_key)" \
  --from-literal=db-password="$(extract db_password)"

echo "==> Restarting deployment"
kubectl rollout restart deployment/slopuploader
kubectl rollout status deployment/slopuploader --timeout=60s

echo "==> Done"