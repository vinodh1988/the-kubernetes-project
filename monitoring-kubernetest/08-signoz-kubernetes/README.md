# 08-signoz-kubernetes

## Overview

SigNoz is an open-source observability platform built around OpenTelemetry, offering metrics, traces, and logs in a unified UI.

## Why choose this

- Open-source APM alternative to commercial platforms
- OTel-native architecture
- Better self-hosted UX than many DIY stacks

## Best use cases

- Cost-sensitive teams needing APM + tracing
- Teams preferring OSS but wanting product-like UX

## Install

Use the official SigNoz Kubernetes installation manifests/charts from upstream docs.

General flow:
1. Create observability namespace
2. Deploy SigNoz components (query-service, collectors, storage)
3. Instrument workloads with OTel SDK/auto-instrumentation

## Verify

```bash
kubectl get pods -n platform-observability
```

Check SigNoz UI:
- Service map visible
- Traces flowing
- Metric panels updating

## Production hardening

- Plan storage for trace/log retention
- Use sampling to reduce ingest cost
- Protect UI and APIs with SSO and RBAC
- Set SLO-driven alert policies

## Pros / Cons

**Pros**
- Open-source with modern observability experience
- OTel-first approach
- Lower license cost vs many SaaS tools

**Cons**
- Self-managed operations still required
- Ecosystem smaller than major commercial vendors

## Worth-it score

- **Value:** High
- **Complexity:** Medium
- **Best for:** OSS-first teams wanting APM capabilities
