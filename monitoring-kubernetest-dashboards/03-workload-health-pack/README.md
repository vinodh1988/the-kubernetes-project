# 03-workload-health-pack

## Purpose

Service and workload reliability dashboards for deployments, pods, and containers.

## Must-have panels

- Deployment desired vs available replicas
- Pod restart and crashloop trends
- Container CPU/memory by workload
- Request/error/latency golden signals (if app metrics available)
- HPA current vs desired replicas

## Best ready-made dashboard sources

- Grafana Community: search `Kubernetes / Views / Pods`, `Deployment`, `Kubernetes workload`
- kube-prometheus-stack workload dashboards

## Import notes

- Add filters: `namespace`, `workload`, `pod`
- Merge infra and app metrics for full context
- Add links to service runbooks from panels

## Alert links to include

- Deployment availability below threshold
- CrashloopBackOff spike
- HPA maxed out repeatedly

## Success output

Application teams should be able to self-triage most incidents from this pack.
