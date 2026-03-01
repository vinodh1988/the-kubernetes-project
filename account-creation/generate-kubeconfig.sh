#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${1:-account-creation}"
SERVICE_ACCOUNT="${2:-account-creation-user}"
OUTPUT_FILE="${3:-account-creation-user.kubeconfig}"

if ! command -v kubectl >/dev/null 2>&1; then
  echo "Error: kubectl is not installed or not in PATH."
  exit 1
fi

if ! kubectl get namespace "$NAMESPACE" >/dev/null 2>&1; then
  echo "Error: Namespace '$NAMESPACE' not found."
  exit 1
fi

if ! kubectl -n "$NAMESPACE" get serviceaccount "$SERVICE_ACCOUNT" >/dev/null 2>&1; then
  echo "Error: ServiceAccount '$SERVICE_ACCOUNT' not found in namespace '$NAMESPACE'."
  exit 1
fi

CURRENT_CONTEXT="$(kubectl config current-context 2>/dev/null || true)"
if [ -z "$CURRENT_CONTEXT" ]; then
  echo "Error: No current kubectl context found."
  exit 1
fi

echo "Using context: $CURRENT_CONTEXT"
echo "Generating kubeconfig: $OUTPUT_FILE"

kubectl config view --raw --minify --flatten > "$OUTPUT_FILE"
TOKEN="$(kubectl -n "$NAMESPACE" create token "$SERVICE_ACCOUNT")"

kubectl --kubeconfig="$OUTPUT_FILE" config set-credentials "$SERVICE_ACCOUNT" --token="$TOKEN" >/dev/null
kubectl --kubeconfig="$OUTPUT_FILE" config set-context --current --user="$SERVICE_ACCOUNT" --namespace="$NAMESPACE" >/dev/null

chmod 600 "$OUTPUT_FILE" 2>/dev/null || true

echo "Done. Kubeconfig generated: $OUTPUT_FILE"
echo "Validation commands:"
echo "  kubectl --kubeconfig=$OUTPUT_FILE get pods -A"
echo "  kubectl --kubeconfig=$OUTPUT_FILE auth can-i create deployment -n default"
echo "  kubectl --kubeconfig=$OUTPUT_FILE auth can-i create deployment -n $NAMESPACE"
