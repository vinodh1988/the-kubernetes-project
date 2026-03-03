# Stack Selection Scorecard

Score each option from 1 (poor) to 5 (excellent).

## Criteria and suggested weights

| Criteria | Weight | Notes |
|---|---:|---|
| Time to value | 15 | How fast can team deploy and adopt? |
| Operational overhead | 15 | Upgrade/tuning burden for your team |
| Cost predictability | 15 | Budget control over 12 months |
| Scalability | 15 | Handles growth in clusters/services/telemetry |
| Feature depth | 10 | Metrics/logs/traces/alerting coverage |
| Vendor lock-in risk | 10 | Exit cost and portability |
| Security/compliance fit | 10 | RBAC/audit/data controls |
| Team skill alignment | 10 | Fit with existing engineering skills |

## Scoring table

| Option | Time | Ops | Cost | Scale | Features | Lock-in | Security | Skills | Weighted total |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| kube-prometheus-stack |  |  |  |  |  |  |  |  |  |
| VictoriaMetrics |  |  |  |  |  |  |  |  |  |
| OpenTelemetry stack |  |  |  |  |  |  |  |  |  |
| Datadog |  |  |  |  |  |  |  |  |  |
| New Relic |  |  |  |  |  |  |  |  |  |
| Dynatrace |  |  |  |  |  |  |  |  |  |
| Elastic |  |  |  |  |  |  |  |  |  |
| SigNoz |  |  |  |  |  |  |  |  |  |
| Pixie (companion) |  |  |  |  |  |  |  |  |  |

## Decision rules

- Pick one **primary stack** for org-wide baseline.
- Optionally pick one **companion tool** for deep debugging (example: Pixie).
- Re-evaluate after 90 days using real MTTR, alert quality, and cost data.

## Example outcomes

- Cost-sensitive OSS strategy: kube-prometheus + OTel + SigNoz/Pixie
- Enterprise managed strategy: Datadog or Dynatrace + OTel standardization
- ELK-centric strategy: Elastic Observability + OTel collector
