# 02-node-capacity-pack

## Purpose

Node-level dashboard pack for capacity management and infra stability.

## Must-have panels

- CPU usage, throttling, load average
- Memory usage, working set, OOM trends
- Disk IO, disk space, inode usage
- Network throughput/errors per node
- Top noisy pods per node

## Best ready-made dashboard sources

- Grafana Community: search `Node Exporter Full` and `Kubernetes Node` dashboards
- kube-prometheus-stack node dashboards

## Import notes

- Ensure `node-exporter` metrics are present
- Normalize node label dimensions (`instance`, `node`, `kubernetes_node`)
- Add threshold annotations for saturation limits

## Alert links to include

- Node memory pressure
- Disk nearing capacity
- CPU throttling sustained

## Success output

Use this pack for weekly capacity review and proactive scaling decisions.
