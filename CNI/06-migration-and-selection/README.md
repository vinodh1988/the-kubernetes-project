# 06 — Selection Framework and Migration Playbook

## 1) Selection framework

Use weighted scoring rather than brand preference.

### Example criteria and weights

| Criterion | Weight (%) | Notes |
|---|---:|---|
| Security policy depth | 20 | L3/L4/L7 needs, auditability |
| Performance/latency | 20 | Real app profile, not synthetic only |
| Observability quality | 15 | Flow visibility, diagnostics, tooling |
| Operational simplicity | 15 | Team skills, runbook burden |
| Cloud/platform fit | 15 | Native integration and constraints |
| Portability/future flexibility | 10 | Multi-cloud or hybrid roadmap |
| Cost impact | 5 | Infra + people + outage risk |

Calculate weighted score:

$$\text{Total Score} = \sum (\text{criterion score} \times \text{weight})$$

## 2) Example short-list by context

- **Regulated multi-tenant platform:** Calico or Cilium with strict policy baseline
- **Cloud-native single provider focus:** AWS VPC CNI / Azure CNI
- **Simple dev/test clusters:** Flannel
- **OVS-centric network teams:** Antrea or OVN-Kubernetes

## 3) Migration triggers

- Need stronger policy enforcement or L7 controls
- Need lower latency/higher throughput
- Need better troubleshooting and observability
- Existing plugin lifecycle/EOL or support concerns

## 4) Migration strategy (low-risk)

### Strategy A: New cluster migration (recommended)

1. Build target cluster with new CNI
2. Replicate policies, ingress, and observability stack
3. Run performance and security acceptance tests
4. Migrate workloads gradually (blue/green or progressive cutover)
5. Decommission old cluster after stability window

### Strategy B: In-place (only if platform supports and risk accepted)

- Requires strict vendor guidance and careful downtime planning
- Higher risk of control-plane/data-plane disruption

## 5) Migration readiness checklist

- Workload dependency map complete
- Policy inventory and translation plan complete
- Benchmark baseline captured
- Rollback and DR test executed
- Stakeholder freeze windows agreed

## 6) Success criteria

- No increase in error rate after migration
- Latency within target budgets
- Policy enforcement verified for critical paths
- Mean time to diagnose network incidents improved
