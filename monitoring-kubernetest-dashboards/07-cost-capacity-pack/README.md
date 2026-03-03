# 07-cost-capacity-pack

## Purpose

Capacity and efficiency dashboard pack to optimize Kubernetes spend and sizing.

## Must-have panels

- Requested vs actual CPU/memory by namespace
- Overprovisioned and underprovisioned workloads
- Spot/preemptible impact trends
- Node utilization heatmap
- Idle resource percentage trend

## Best ready-made dashboard sources

- Grafana Community dashboards for resource efficiency
- Kubecost/OpenCost visualization dashboards (if installed)

## Import notes

- Ensure requests/limits metrics are available from kube-state-metrics
- Add team/business labels for chargeback visibility
- Pair with rightsizing recommendation outputs

## Alert links to include

- Namespace with persistent underutilization
- Saturated namespaces requiring scale-up
- Cost anomaly spikes

## Success output

Supports monthly optimization reviews and cloud cost control.
