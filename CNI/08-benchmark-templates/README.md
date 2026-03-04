# 08 — Vendor-Specific Benchmark Templates

This section provides a **repeatable benchmarking framework** plus vendor-specific profiles.

## Files in this section

- `benchmark-plan-template.md` — master plan template for any CNI
- `cilium-benchmark-profile.md` — eBPF-focused benchmark profile
- `calico-benchmark-profile.md` — iptables/eBPF benchmark profile
- `flannel-benchmark-profile.md` — lightweight overlay baseline profile
- `aws-vpc-cni-benchmark-profile.md` — EKS native networking profile
- `azure-cni-benchmark-profile.md` — AKS native networking profile

## Benchmark principles

1. Compare CNIs on **identical infrastructure**.
2. Keep Kubernetes version, node size, image versions, and workload mix consistent.
3. Benchmark both **steady state** and **churn** (rollout, HPA, node drain).
4. Capture both **performance** and **operability** metrics.
5. Run at least 3 test rounds and compare variance.

## Core metric set

- Latency: p50, p95, p99
- Throughput: requests/sec, bits/sec
- Reliability: error rate, timeouts, packet drops
- Resource use: node CPU, memory, network interrupts
- Control plane/cni health: agent restarts, reconciliation lag
- Policy impact: latency delta with policies enabled

## Suggested test categories

- Pod-to-pod same-node
- Pod-to-pod cross-node
- Pod-to-service (ClusterIP)
- Ingress north-south path
- DNS under load
- NetworkPolicy allow/deny with high cardinality
- Scale tests (pod count and node count growth)

## Tooling examples

- Traffic/load: `k6`, `wrk2`, `iperf3`, `fortio`
- Cluster metrics: Prometheus + Grafana
- CNI visibility: plugin-specific CLIs and flow tools

## Output artifact checklist

- Raw results CSV/JSON
- Grafana screenshots/exported panels
- Test environment manifest (versions and flags)
- Incident notes for anomalies
- Final recommendation with weighted scoring
