#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

extract() {
  sops -d --extract "[\"slopuploader\"][\"$1\"]" secrets/secrets.yaml
}

echo "==> Recreating slopuploader-secrets"
sudo kubectl delete secret slopuploader-secrets --ignore-not-found
sudo kubectl create secret generic slopuploader-secrets \
  --from-literal=admin-token="$(extract admin_token)" \
  --from-literal=s3-access-key="$(extract s3_access_key)" \
  --from-literal=s3-secret-key="$(extract s3_secret_key)" \
  --from-literal=db-password="$(extract db_password)"

echo "==> Restarting deployment"
sudo kubectl rollout restart deployment/slopuploader
sudo kubectl rollout status deployment/slopuploader --timeout=60s

echo "==> Done"