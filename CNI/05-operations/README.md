# 05 — Day-2 Operations and Troubleshooting

## 1) Production operating model

- Define ownership: platform team owns CNI lifecycle and guardrails
- Standardize runbooks for incidents and upgrades
- Maintain staging cluster parity for safe validation

## 2) Installation and lifecycle strategies

### Common install methods

- Managed distribution defaults (AKS/EKS/GKE/OpenShift)
- Helm-based install for self-managed clusters
- GitOps for declarative lifecycle control

### Upgrade strategy

1. Read plugin and Kubernetes version compatibility matrix
2. Test in non-prod with production-like traffic shape
3. Perform canary node pool/cluster upgrade
4. Observe packet loss, latency, policy enforcement correctness
5. Roll out gradually with rollback checkpoints

## 3) SLOs and key metrics

Track at minimum:

- Pod-to-pod latency p95/p99
- Service request success rate
- Packet drops by reason
- DNS resolution latency and failure rate
- CNI agent CPU/memory and restart count

## 4) Observability components

- CNI controller/agent logs
- Node kernel networking counters
- Flow logs and policy decision logs
- kube-proxy or eBPF service metrics

## 5) Incident response flow

1. Scope: single pod, namespace, node, or cluster-wide?
2. Path check: DNS → service VIP → endpoint pod
3. Policy check: selected policies and effective allow/deny
4. Node check: interface/routes/tunnel state
5. CNI agent health and recent config churn
6. Rollback or isolate changes if regression suspected

## 6) Troubleshooting command examples

```bash
kubectl get pods -A -o wide
kubectl get networkpolicy -A
kubectl describe networkpolicy -n <ns> <name>
kubectl get endpoints -n <ns> <svc>
kubectl logs -n kube-system -l k8s-app=<cni-agent-label>
```

Plugin-specific tooling examples:

- Cilium: `cilium status`, `hubble observe`
- Calico: `calicoctl node status`, `calicoctl get policy`

## 7) High-frequency failure modes

- MTU mismatch causing intermittent drops
- Subnet/IP exhaustion blocking new pod scheduling
- Policy rollouts that unintentionally block DNS/metrics
- Asymmetric routing or stale conntrack state

## 8) Operational hardening

- Pin known-good plugin and kernel combinations
- Enforce policy linting/tests in CI
- Keep emergency break-glass policy and rollback docs ready
- Run quarterly game-days focused on network partitions/policy lockouts
