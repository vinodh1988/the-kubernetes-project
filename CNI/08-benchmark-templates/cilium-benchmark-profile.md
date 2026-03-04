# Cilium Benchmark Profile

## Scope focus

- eBPF data plane performance
- kube-proxy replacement behavior (if enabled)
- Policy and observability overhead

## Configuration checklist

- Cilium version:
- kube-proxy replacement mode:
- Hubble enabled:
- Encryption mode (WireGuard/IPsec/none):
- MTU value:

## Must-run tests

1. Service routing latency with and without kube-proxy replacement
2. NetworkPolicy enforcement overhead at increasing policy cardinality
3. DNS visibility and flow export overhead with Hubble enabled
4. High connection churn (short-lived connections)

## Key observations to capture

- p95/p99 latency delta vs baseline
- CPU cost of policy + observability
- Drop reasons from Cilium/Hubble flow telemetry
- Any kernel compatibility warnings

## Verdict prompts

- Does eBPF path reduce tail latency for your workload?
- Is observability value worth resource overhead?
- Are operations teams comfortable with tooling and debug flow?
