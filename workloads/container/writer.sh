#!/bin/sh
set -eu

MODE="${MODE:-once}"
TARGET_DIR="${TARGET_DIR:-/data/shared}"
PREFIX="${PREFIX:-workload}"
INTERVAL_SECONDS="${INTERVAL_SECONDS:-10}"
NODE_NAME="${NODE_NAME:-unknown-node}"
POD_NAME="${POD_NAME:-unknown-pod}"
NAMESPACE="${NAMESPACE:-unknown-ns}"

mkdir -p "${TARGET_DIR}"

write_line() {
  timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  line="${timestamp} mode=${MODE} prefix=${PREFIX} ns=${NAMESPACE} pod=${POD_NAME} node=${NODE_NAME}"

  echo "${line}" | tee -a "${TARGET_DIR}/activity.log" >> "${TARGET_DIR}/${PREFIX}.log"
}

case "${MODE}" in
  once)
    write_line
    ;;
  loop)
    while true; do
      write_line
      sleep "${INTERVAL_SECONDS}"
    done
    ;;
  *)
    echo "Unsupported MODE: ${MODE}. Use 'once' or 'loop'." >&2
    exit 1
    ;;
esac
