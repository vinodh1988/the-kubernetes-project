# Dashboard Provisioning Guide (Kubernetes)

This guide helps you manage Kubernetes dashboards as code.

## Option A - Fast import from Grafana UI

1. Open Grafana -> Dashboards -> Import
2. Import by dashboard ID/JSON
3. Select your Prometheus datasource
4. Save in a folder per team/domain

Best for: quick bootstrap and experimentation.

## Option B - Provision dashboards via ConfigMap

Use ConfigMaps and Grafana sidecar provisioning so dashboards are versioned in Git.

High-level flow:

1. Store dashboard JSON files in Git
2. Create ConfigMaps with labels (e.g. `grafana_dashboard: "1"`)
3. Enable dashboard sidecar in Grafana chart values
4. Roll out via CI/CD

## Recommended folder strategy in Grafana

- `K8s / Cluster`
- `K8s / Nodes`
- `K8s / Workloads`
- `K8s / Networking`
- `K8s / Storage`
- `K8s / Control Plane`
- `K8s / Capacity & Cost`
- `K8s / mSLOs`

## Datasource assumptions

Most ready-made K8s dashboards assume Prometheus metric names from:

- kube-state-metrics
- node-exporter
- cAdvisor
- API server metrics

If panels are empty, validate metric names and label keys in your environment.

## Dashboard lifecycle governance

- Assign owner per dashboard
- Include runbook links in panel descriptions
- Pin reviewed versions in Git
- Run monthly dashboard cleanup (unused/duplicate)
- Keep naming consistent with namespaces/services

## Alert mapping rule

Each critical panel should map to one alert rule:

- High CPU saturation
- Pod crashloop or restart spikes
- API server latency/error budget burn
- Storage pressure and PVC capacity risk

## Production checklist

- Dashboard import/provisioning automated
- RBAC and folder permissions applied
- Datasource credentials secured
- Dashboard changes reviewed in PR
- Backup dashboards before major upgrades
