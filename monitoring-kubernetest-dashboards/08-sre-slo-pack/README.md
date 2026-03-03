# 08-sre-slo-pack

## Purpose

SRE-focused reliability dashboards centered on SLOs and error budgets.

## Must-have panels

- Availability SLI and error budget remaining
- Latency SLI (p95/p99) by critical service
- Burn-rate windows (fast + slow)
- Incident count and MTTR trend
- Top alert noise contributors

## Best ready-made dashboard sources

- SLO dashboards from Prometheus + Grafana mixin patterns
- Community SRE dashboard templates (error budget/burn rate)

## Import notes

- Build service-level variables (`service`, `env`, `region`)
- Align panel thresholds with formal SLO policy
- Include links to incident runbooks and postmortems

## Alert links to include

- Multi-window burn-rate alerts
- Error budget exhaustion risk
- Persistent latency SLO violations

## Success output

Moves monitoring from raw infra metrics to user-impact reliability outcomes.
