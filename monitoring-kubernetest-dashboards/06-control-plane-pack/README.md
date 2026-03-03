# 06-control-plane-pack

## Purpose

Control-plane observability dashboards for API server, scheduler, controller manager, and etcd (where available).

## Must-have panels

- API server request rate/latency/error code
- Admission webhook latency/failures
- Scheduler queue and binding latency
- Controller workqueue depth and retries
- etcd request latency and leader health

## Best ready-made dashboard sources

- kube-prometheus-stack control-plane dashboards
- Grafana Community: search `Kubernetes API Server` and `etcd`

## Import notes

- Managed clusters may expose fewer control-plane metrics
- Adjust queries for cloud-provider metric availability
- Separate read-only dashboard access for incident responders

## Alert links to include

- API server high latency / 5xx
- etcd quorum or high latency risk
- Scheduler throughput degradation

## Success output

Critical for identifying platform-side issues vs workload-side issues quickly.
