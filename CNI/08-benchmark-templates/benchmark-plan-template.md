# Benchmark Plan Template (Generic CNI)

## 1) Objective

- Business goal:
- Technical goal:
- Decision to be made:

## 2) Environment baseline

| Field | Value |
|---|---|
| Kubernetes version | |
| Node OS / kernel | |
| Node instance type | |
| Node count | |
| CNI plugin + version | |
| kube-proxy mode / replacement | |
| Service mesh present | |
| Ingress controller | |

## 3) Test matrix

| Test ID | Scenario | Traffic shape | Duration | Pass criteria |
|---|---|---|---|---|
| T1 | Same-node pod-to-pod | | | |
| T2 | Cross-node pod-to-pod | | | |
| T3 | Service VIP path | | | |
| T4 | DNS under load | | | |
| T5 | Policy at scale | | | |
| T6 | Churn (HPA/rollout) | | | |

## 4) Workload profiles

- Profile A (latency-sensitive):
- Profile B (throughput-heavy):
- Profile C (mixed read/write):

## 5) Measurements to collect

- App-level latency p50/p95/p99
- Throughput and success rate
- Node CPU/memory
- Network drops/retransmits
- CNI agent resource usage and restart count
- Policy decision logs and dropped-flow reasons

## 6) Execution procedure

1. Deploy baseline workloads.
2. Warm-up traffic for fixed interval.
3. Run test scenario.
4. Export metrics and logs.
5. Repeat for 3 rounds.
6. Compute median and variance.

## 7) Risk controls

- Freeze other cluster changes during benchmark window.
- Use dedicated namespace and reproducible manifests.
- Record all feature flags and non-default settings.

## 8) Result summary template

| Scenario | Candidate A | Candidate B | Candidate C | Winner |
|---|---:|---:|---:|---|
| Latency p95 (ms) | | | | |
| Throughput (rps) | | | | |
| Error rate (%) | | | | |
| CPU/node (%) | | | | |
| Operations score (1-5) | | | | |

## 9) Recommendation

- Selected CNI:
- Why:
- Risks:
- Follow-up actions:
