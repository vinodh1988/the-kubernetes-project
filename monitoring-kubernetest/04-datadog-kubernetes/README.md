# 04-datadog-kubernetes

## Overview

Datadog provides a managed Kubernetes observability platform (metrics, logs, traces, security, synthetics) with fast onboarding.

## Why choose this

- Minimal operations burden
- Powerful out-of-box Kubernetes integrations
- Strong enterprise alerting and incident workflows

## Best use cases

- Teams prioritizing speed and managed experience
- Organizations with strong budget, low ops tolerance
- Enterprises needing broad observability + security integration

## Install (Helm)

```bash
helm repo add datadog https://helm.datadoghq.com
helm repo update

kubectl create namespace datadog
helm upgrade --install datadog-agent datadog/datadog \
  --namespace datadog \
  --set datadog.apiKey=<YOUR_API_KEY> \
  --set datadog.site=datadoghq.com
```

## Verify

```bash
kubectl get pods -n datadog
kubectl logs -n datadog daemonset/datadog-agent
```

Check Datadog UI for:
- Nodes and pods discovered
- APM traces arriving
- Monitors firing/resolving correctly

## Production hardening

- Scope data collection to control billable volume
- Enable tag strategy for ownership/environment
- Configure monitor templates and escalation policies
- Review log ingestion filters and retention tiers

## Pros / Cons

**Pros**
- Fastest path to full observability
- Excellent UX and integrations
- Low maintenance burden

**Cons**
- High recurring cost at scale
- Vendor lock-in risk

## Worth-it score

- **Value:** High (if budget allows)
- **Complexity:** Low-Medium
- **Best for:** Enterprise teams optimizing for speed and support
