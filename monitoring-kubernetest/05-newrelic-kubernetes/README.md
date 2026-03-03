# 05-newrelic-kubernetes

## Overview

New Relic’s Kubernetes integration offers managed observability with strong dashboards, APM, logs, and alerting.

## Why choose this

- Straightforward onboarding
- Unified telemetry view
- Good UX for application and platform teams

## Best use cases

- Teams wanting managed monitoring with moderate complexity
- Organizations combining infra + app observability quickly

## Install (Helm)

```bash
helm repo add newrelic https://helm-charts.newrelic.com
helm repo update

kubectl create namespace newrelic
helm upgrade --install newrelic-bundle newrelic/nri-bundle \
  --namespace newrelic \
  --set global.licenseKey=<YOUR_LICENSE_KEY> \
  --set global.cluster=<YOUR_CLUSTER_NAME>
```

## Verify

```bash
kubectl get pods -n newrelic
kubectl logs -n newrelic daemonset/newrelic-infra-agent
```

Check New Relic UI for cluster entities, alerts, and service telemetry.

## Production hardening

- Apply data-inclusion filters for cost control
- Normalize entity naming conventions
- Configure NRQL-based SLO dashboards and alerts
- Integrate incidents with on-call platform

## Pros / Cons

**Pros**
- Good balance of usability and capability
- Fast time-to-value
- Strong visualization and query model

**Cons**
- Pricing can rise with telemetry volume
- Less backend-level control than pure OSS stacks

## Worth-it score

- **Value:** High
- **Complexity:** Low-Medium
- **Best for:** Teams wanting managed observability with rapid adoption
