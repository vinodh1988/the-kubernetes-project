# 04 — CNI Security and Policy Design

## 1) Security goals for Kubernetes networking

- Namespace and tenant isolation
- Least-privilege east-west traffic
- Controlled north-south ingress/egress
- Auditable enforcement and incident response visibility

## 2) NetworkPolicy design model

### Start with default deny

- Apply namespace-level default deny ingress and egress.
- Add explicit allow rules per app dependency graph.

### Build layered policy

- Namespace baseline policy
- Application-specific ingress/egress policy
- Platform exceptions (DNS, metrics, identity, time sync)

## 3) Typical policy architecture

1. Deny-all baseline for each namespace
2. Allow DNS egress to cluster DNS
3. Allow app-to-app traffic by labels and ports
4. Allow ingress from Ingress controller namespace
5. Restrict external egress through approved gateways

## 4) Encryption choices

- **In-transit encryption:** WireGuard or IPsec where supported
- **Cloud-native encryption:** provider VPC/VNet features where applicable
- **Service mesh mTLS:** complements CNI encryption for workload identity

## 5) Multi-tenant patterns

- Hard namespace boundaries with default deny
- Distinct node pools for sensitive workloads
- Egress controls per tenant to prevent data exfiltration
- Dedicated observability and audit trails per tenant/domain

## 6) Compliance mapping hints

For SOC2/ISO27001/PCI-style controls, map CNI controls to:

- Access control: policy-as-code + review workflows
- Data in transit: encryption configs and key rotation evidence
- Monitoring: flow logs, denied traffic logs, anomaly alerts
- Change management: versioned policy repos and approval traces

## 7) Security anti-patterns

- Allowing all egress by default indefinitely
- Policy labels that are too broad (e.g., wildcard app selectors)
- No policy test pipeline before production rollout
- Enabling encryption without capacity/performance testing

## 8) Practical validation checklist

- Verify blocked paths are truly blocked
- Verify allowed paths still work after rollout
- Capture flow logs for both allow and deny paths
- Run periodic drift detection for policy config changes
