# monitoring-kubernetest-dashboards

Ready-made Kubernetes **dashboard project pack** with multiple sub-project folders.

This project is focused on **dashboards only** (not monitoring tools comparison).

## What this project gives you

- Curated dashboard packs for core Kubernetes monitoring domains
- Import strategy for Grafana (UI and provisioning)
- Practical KPI/alert mapping for each dashboard pack
- Rollout path from MVP to production dashboard governance

## Dashboard sub-projects

1. `01-cluster-overview-pack`
2. `02-node-capacity-pack`
3. `03-workload-health-pack`
4. `04-networking-ingress-pack`
5. `05-storage-stateful-pack`
6. `06-control-plane-pack`
7. `07-cost-capacity-pack`
8. `08-sre-slo-pack`

## Best dashboard sources for Kubernetes

- Grafana Community dashboards (fast bootstrap)
- kube-prometheus-stack built-in dashboards (strong baseline)
- Kubernetes mixin dashboard style (SRE oriented)
- Cloud-specific managed dashboard templates (AKS/EKS/GKE variants)

## Recommended rollout order

1. Start with `01`, `02`, `03` for immediate visibility
2. Add `04`, `05`, `06` for platform depth
3. Add `07`, `08` for optimization and reliability maturity

## Dashboard quality standards

- Every dashboard should have owner/team tags
- Every critical panel should map to an alert/runbook
- Keep panel count focused (high signal, low noise)
- Review stale/unused dashboards monthly

## Success criteria

- Critical incidents triaged from dashboards in < 5 minutes
- Reduced alert noise and faster root-cause navigation
- Clear shared dashboards for platform + service teams

See [DASHBOARD-PROVISIONING-GUIDE.md](DASHBOARD-PROVISIONING-GUIDE.md) for implementation details.
