# monitoring-kubernetest

A practical Kubernetes monitoring workspace with **multiple sub-projects**, each representing a strong monitoring stack/library.

This is designed to help you choose quickly based on scale, budget, team maturity, and compliance requirements.

## What you get

- Multiple monitoring options (open-source and managed)
- A clear decision matrix
- Production-focused setup guidance per option
- Validation checklist for each stack

## Sub-projects

1. `01-kube-prometheus-stack` - Prometheus + Grafana + Alertmanager (community standard)
2. `02-victoriametrics-operator` - High-scale metrics with lower infra cost
3. `03-opentelemetry-collector-stack` - Vendor-neutral observability pipeline
4. `04-datadog-kubernetes` - Managed, full-featured enterprise monitoring
5. `05-newrelic-kubernetes` - Managed observability with strong UX
6. `06-dynatrace-kubernetes` - Enterprise AI-assisted observability
7. `07-elastic-observability-k8s` - Logs + metrics + traces in Elastic ecosystem
8. `08-signoz-kubernetes` - Open-source APM/observability with OpenTelemetry
9. `09-pixie-ebpf-observability` - eBPF-based deep runtime visibility

## Decision matrix (quick)

| Option | Best for | Cost profile | Ops overhead | Lock-in risk |
|---|---|---|---|---|
| kube-prometheus-stack | Default OSS baseline | Low-Medium | Medium | Low |
| VictoriaMetrics | Large metrics cardinality & retention | Low | Medium | Low |
| OpenTelemetry stack | Vendor-neutral telemetry control | Low-Medium | Medium-High | Low |
| Datadog | Fast enterprise adoption | High | Low | Medium-High |
| New Relic | Easy setup + good dashboards | Medium-High | Low | Medium |
| Dynatrace | Regulated/large enterprise operations | High | Low-Medium | High |
| Elastic | Teams already on ELK | Medium-High | Medium | Medium |
| SigNoz | OSS APM with modern UX | Low-Medium | Medium | Low |
| Pixie | Live protocol-level troubleshooting | Medium | Medium | Medium |

## Recommended adoption path

1. Start with `01-kube-prometheus-stack` for core metrics and alerts.
2. Add `03-opentelemetry-collector-stack` for portable traces/log pipelines.
3. If scale cost increases, evaluate `02-victoriametrics-operator`.
4. If your org wants managed operations, choose one of `04/05/06`.
5. Add `09-pixie-ebpf-observability` for deep live debugging.

## Common prerequisites

- Kubernetes cluster (v1.26+ recommended)
- `kubectl` access with namespace creation permissions
- `helm` v3
- Ingress or LoadBalancer access for UIs
- Optional: cert-manager, external DNS, cloud storage for long retention

## Production checklist (applies to all)

- Define SLOs and alert severity policy before installing tools
- Route alerts to on-call channels (PagerDuty, Teams, Slack)
- Keep dashboards ownership clear per team/service
- Set retention and sampling to manage cost
- Use RBAC + secret management for all monitoring credentials
- Run periodic alert quality reviews (reduce noisy alerts)

## How to use this workspace

- Open each sub-project folder README
- Follow install + verify sections
- Compare trade-offs with your team
- Standardize on one primary stack and one optional deep-debugging stack

---

If you want, this can be extended with ready-to-apply Helm values and manifests for your target cloud (AKS/EKS/GKE).
