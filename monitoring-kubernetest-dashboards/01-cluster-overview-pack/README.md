# 01-cluster-overview-pack

## Purpose

Executive and platform-level **single pane** dashboard for real-time Kubernetes health.

## Must-have panels

- Cluster CPU/Memory utilization
- Node readiness and pressure states
- Running vs pending/failed pods
- Deployment availability trend
- Top namespaces by error/restarts

## Best ready-made dashboard sources

- Grafana Community: search for `Kubernetes cluster monitoring` and `Kubernetes / Views / Global`
- kube-prometheus-stack default cluster dashboards

## Import notes

- Map datasource to your primary Prometheus
- Validate namespace and cluster label filters
- Add templating variables: `cluster`, `namespace`, `node`

## Alert links to include

- Node NotReady
- High pod restart rate
- Cluster resource saturation

## Success output

If this dashboard is good, on-call can answer in 2 minutes:

- Is cluster healthy?
- Is issue isolated or broad?
- Which namespace is degrading?
