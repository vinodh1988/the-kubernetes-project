# 09-pixie-ebpf-observability

## Overview

Pixie uses eBPF for automatic, code-free telemetry collection (especially useful for network/runtime debugging in Kubernetes).

## Why choose this

- Deep protocol-level visibility without heavy app instrumentation
- Fast troubleshooting for service latency/errors
- Strong complement to a primary monitoring stack

## Best use cases

- Incident response and performance debugging
- Platform teams diagnosing network/service behavior

## Install

Follow Pixie cloud/self-hosted installation guide for your environment.

Typical flow:
1. Install Pixie operator/components
2. Register cluster
3. Open Pixie UI/CLI scripts for live inspection

## Verify

```bash
kubectl get pods -A | findstr /I pixie
```

Check:
- Live HTTP/gRPC telemetry captured
- Pod/service-level scripts returning data

## Production hardening

- Review kernel/eBPF compatibility with node OS
- Restrict data access based on team boundaries
- Keep it as a complementary tool, not sole source of truth

## Pros / Cons

**Pros**
- Excellent real-time debugging visibility
- Minimal app code changes needed
- Strong operational troubleshooting value

**Cons**
- Not a complete replacement for metrics+alert stack
- Compatibility/operations considerations per environment

## Worth-it score

- **Value:** High (as companion tool)
- **Complexity:** Medium
- **Best for:** Deep troubleshooting in Kubernetes workloads
