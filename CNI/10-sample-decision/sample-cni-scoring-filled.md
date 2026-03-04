# Sample CNI Scoring Worksheet (Filled Example)

## Context

- Environment: EKS, mixed microservices and internal APIs
- Priority order: security and performance first, portability second

## Criteria and weights

| Criterion | Weight |
|---|---:|
| Security policy depth | 20 |
| Performance / latency | 20 |
| Observability | 15 |
| Operational simplicity | 15 |
| Cloud/platform fit | 15 |
| Portability | 10 |
| Cost impact | 5 |
| **Total** | **100** |

## Completed scoring

| Criterion | Weight | Cilium Raw | Cilium Weighted | Calico Raw | Calico Weighted | AWS VPC CNI Raw | AWS VPC CNI Weighted |
|---|---:|---:|---:|---:|---:|---:|---:|
| Security policy depth | 20 | 5 | 20 | 5 | 20 | 3 | 12 |
| Performance / latency | 20 | 5 | 20 | 4 | 16 | 4 | 16 |
| Observability | 15 | 5 | 15 | 4 | 12 | 3 | 9 |
| Operational simplicity | 15 | 3 | 9 | 4 | 12 | 5 | 15 |
| Cloud/platform fit | 15 | 4 | 12 | 4 | 12 | 5 | 15 |
| Portability | 10 | 5 | 10 | 5 | 10 | 1 | 2 |
| Cost impact | 5 | 3 | 3 | 4 | 4 | 5 | 5 |
| **Total** | **100** |  | **89** |  | **86** |  | **74** |

## Why these example numbers

### Cilium

- Excellent policy depth and eBPF observability profile
- Strong performance in service and policy path in many environments
- Slightly lower operations simplicity score due to team skill requirements

### Calico

- Very strong policy and broad ecosystem maturity
- High operational familiarity in many platform teams
- Strong portability profile

### AWS VPC CNI

- Excellent AWS-native fit and operational simplicity in EKS-first contexts
- Good core performance with native VPC routing
- Lower portability and less advanced Kubernetes-native policy depth unless paired with additional controls

## Example recommendation

If your strategy is policy-first with future multi-cloud optionality:

- Prefer Cilium or Calico final short-list
- Use benchmarks and policy test evidence to pick final winner

If your strategy is strict AWS-native simplicity with lower portability needs:

- AWS VPC CNI can be the practical first choice

## Decision caveat

This is an example only. Replace the raw scores with your own benchmark and operational trial results.
