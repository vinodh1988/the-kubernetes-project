# Calico Benchmark Profile

## Scope focus

- Compare iptables mode vs eBPF mode (if in scope)
- Policy scale behavior
- Route distribution/BGP behavior where used

## Configuration checklist

- Calico version:
- Dataplane mode (iptables/eBPF):
- Typha enabled (large clusters):
- BGP enabled:
- Encryption mode (WireGuard/IPsec/none):

## Must-run tests

1. Service and pod path latency under iptables and/or eBPF mode
2. Policy scale test with growing selectors and rules
3. Node churn test (node restart/drain) and route convergence check
4. DNS + ingress path validation under policy constraints

## Key observations to capture

- Rule count growth effect on latency/CPU
- Agent stability and reconciliation time
- Policy correctness and troubleshooting effort
- Operational complexity for BGP/network team workflows

## Verdict prompts

- Is policy model strong enough for current and future segmentation?
- Is operational effort acceptable at expected cluster scale?
- Which mode gives best balance of performance and operability?
