# 03-opentelemetry-collector-stack

## Overview

OpenTelemetry (OTel) Collector provides a vendor-neutral telemetry pipeline for metrics, logs, and traces.

Core pattern:
- App SDKs/agents -> OTel Collector -> one or more backends (Prometheus/Tempo/Loki/Datadog/etc.)

## Why choose this

- Standardized observability instrumentation
- Easy multi-backend routing and migration
- Strong future-proofing against vendor lock-in

## Best use cases

- Platform teams standardizing telemetry across services
- Organizations planning backend flexibility
- Multi-tenant environments with governance requirements

## Install (basic collector)

```bash
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update

kubectl create namespace observability
helm upgrade --install otel-collector open-telemetry/opentelemetry-collector \
  --namespace observability
```

Deploy as `DaemonSet` for node collection or `Deployment` for centralized pipelines.

## Verify

```bash
kubectl get pods -n observability
kubectl logs -n observability deploy/otel-collector
```

Check:
- Collector receives telemetry
- Exporters are successful (no retry storms)
- Sampling and batching rules apply correctly

## Production hardening

- Define data governance: redact sensitive attributes
- Configure tail/head sampling for trace volume control
- Use queue/retry/batch processors to reduce drops
- Add HPA for collector under bursty workloads

## Pros / Cons

**Pros**
- Vendor-neutral standard
- Flexible pipeline transformations
- Strong long-term architecture choice

**Cons**
- More design decisions upfront
- Requires disciplined instrumentation standards

## Worth-it score

- **Value:** Very High
- **Complexity:** Medium-High
- **Best for:** Standardizing telemetry in growing organizations
