# 01-kube-prometheus-stack

## Overview

`kube-prometheus-stack` (Prometheus Operator bundle) is the most common open-source Kubernetes monitoring baseline:

- Prometheus (metrics)
- Alertmanager (alert routing)
- Grafana (dashboards)
- kube-state-metrics + node-exporter (cluster visibility)

## Why choose this

- Strong community standard
- Excellent dashboard/alert ecosystem
- Flexible and cloud-agnostic
- Good fit for platform teams with SRE ownership

## Best use cases

- Internal platform observability foundation
- Teams needing full control over metrics/alerts
- Organizations avoiding vendor lock-in

## Install (Helm)

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create namespace monitoring
helm upgrade --install kube-prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring
```

## Verify

```bash
kubectl get pods -n monitoring
kubectl get svc -n monitoring
kubectl get prometheus,alertmanager -n monitoring
```

Check:
- Prometheus targets are healthy
- Alertmanager routes notifications
- Grafana dashboards load cluster metrics

## Production hardening

- Enable persistent volumes for Prometheus and Grafana
- Configure Alertmanager receivers (PagerDuty/Slack/Teams)
- Restrict Grafana access via SSO + RBAC
- Set retention and resource limits intentionally
- Use remote write for long-term storage

## Pros / Cons

**Pros**
- Mature ecosystem
- Highly customizable
- No required SaaS dependency

**Cons**
- Operational overhead (upgrades/tuning)
- Cardinality explosion risk if unmanaged
- Long-term storage requires extra components

## Worth-it score

- **Value:** High
- **Complexity:** Medium
- **Best for:** Most teams as first serious monitoring stack
