# Quickstart (Dashboard-Only)

## 1) Prerequisites

- Prometheus datasource already available in Grafana
- kube-state-metrics and node-exporter metrics present
- Grafana folder permissions configured

## 2) Import order (recommended)

1. Cluster overview
2. Node capacity
3. Workload health
4. Networking/ingress
5. Storage/stateful
6. Control plane
7. Cost/capacity
8. SRE/SLO

## 3) 1-hour MVP checklist

- Import one dashboard from packs 01/02/03
- Validate non-empty panels and filters
- Add 3 critical alert links in panel descriptions
- Share dashboard links with on-call channel

## 4) 1-week production checklist

- Move dashboards to Git-backed provisioning
- Assign dashboard owners
- Review and remove duplicate/noisy panels
- Add runbook links to all critical sections

## 5) What to avoid

- Huge dashboards with 80+ panels
- Mixed environments without variables
- Dashboards without alert/runbook mapping
- Unowned dashboards nobody maintains
