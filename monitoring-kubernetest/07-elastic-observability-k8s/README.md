# 07-elastic-observability-k8s

## Overview

Elastic Observability on Kubernetes combines logs, metrics, traces, and security analytics in the Elastic ecosystem.

## Why choose this

- Unified search and analytics experience
- Strong when ELK is already organizational standard
- Flexible deployment model (self-managed or cloud)

## Best use cases

- Organizations already using Elasticsearch/Kibana
- Teams needing powerful log analytics and correlation

## Install (ECK operator + agents)

```bash
kubectl create namespace elastic-system
kubectl apply -f https://download.elastic.co/downloads/eck/2.14.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.14.0/operator.yaml
```

Then deploy Elasticsearch/Kibana/Agent resources for telemetry collection.

## Verify

```bash
kubectl get pods -n elastic-system
kubectl get elasticsearch,kibana,agent -A
```

Check Kibana Observability for cluster entities and log/trace correlation.

## Production hardening

- Right-size Elasticsearch data tiers
- Apply ILM (Index Lifecycle Management)
- Secure with TLS, RBAC, and secret rotation
- Set parsing/enrichment standards for logs

## Pros / Cons

**Pros**
- Excellent search and log analytics
- Good integration if ELK already adopted
- Strong ecosystem for data enrichment

**Cons**
- Can be resource-intensive
- More operational complexity if self-managed

## Worth-it score

- **Value:** High (ELK orgs)
- **Complexity:** Medium-High
- **Best for:** Log-heavy teams and Elastic-first organizations
