# 02-victoriametrics-operator

## Overview

VictoriaMetrics is a high-performance metrics/time-series database often used as a Prometheus-compatible backend with better scale/cost efficiency.

## Why choose this

- Handles high-cardinality metrics better than many defaults
- Lower CPU/storage footprint for large clusters
- Prometheus-compatible ingestion/query path

## Best use cases

- Large clusters or many clusters
- Long retention with lower infra cost pressure
- Teams hitting Prometheus scaling limits

## Install (operator)

```bash
helm repo add vm https://victoriametrics.github.io/helm-charts/
helm repo update

kubectl create namespace monitoring
helm upgrade --install vm-operator vm/victoria-metrics-operator \
  --namespace monitoring
```

Then deploy `VMCluster`, `VMAgent`, and scrape configs per environment.

## Verify

```bash
kubectl get pods -n monitoring
kubectl get crd | findstr /I "victoriametrics"
```

Check:
- Scrape targets ingesting metrics
- Query latency stable under load
- Retention behaving as expected

## Production hardening

- Use remote backup/object storage strategy
- Tune retention and downsampling policies
- Capacity-plan for multi-tenant workloads
- Add recording rules to reduce query cost

## Pros / Cons

**Pros**
- Excellent scale-to-cost efficiency
- Prometheus-compatible workflow
- Good choice for metrics-heavy platforms

**Cons**
- Smaller ecosystem than Prometheus/Grafana mainstream docs
- Additional migration planning from existing stack

## Worth-it score

- **Value:** Very High (at scale)
- **Complexity:** Medium
- **Best for:** Cost-efficient, large-scale metrics monitoring
