# 06-dynatrace-kubernetes

## Overview

Dynatrace provides enterprise-grade Kubernetes observability with AI-assisted anomaly detection, topology mapping, and strong governance support.

## Why choose this

- Deep enterprise observability and automation
- Strong root-cause analysis workflows
- Mature support for regulated environments

## Best use cases

- Large enterprises with strict compliance controls
- Teams needing advanced AI-assisted analysis
- Organizations consolidating observability + security insights

## Install (Operator)

```bash
kubectl create namespace dynatrace
helm repo add dynatrace https://raw.githubusercontent.com/Dynatrace/helm-charts/master/repos/stable
helm repo update

helm upgrade --install dynatrace-operator dynatrace/dynatrace-operator \
  --namespace dynatrace
```

Then create Dynatrace custom resources with API URL/tokens.

## Verify

```bash
kubectl get pods -n dynatrace
kubectl get crd | findstr /I dynatrace
```

Check Dynatrace UI for OneAgent/ActiveGate health and cluster telemetry.

## Production hardening

- Apply strict token scopes and rotation policy
- Segment environments for tenancy/security boundaries
- Tune data ingestion policy and retention tiers
- Integrate with enterprise incident systems

## Pros / Cons

**Pros**
- Strong enterprise observability depth
- Excellent topology and causation insights
- Mature governance features

**Cons**
- Premium pricing
- Higher onboarding complexity for small teams

## Worth-it score

- **Value:** Very High (enterprise)
- **Complexity:** Medium
- **Best for:** Large regulated organizations
