# 07 — Hands-on Labs and Validation

## Lab 1 — Baseline connectivity and service path

### Goals

- Validate pod-to-pod communication
- Validate service VIP routing and endpoint selection

### Steps

1. Deploy 2 namespaces and sample apps.
2. Expose one app with ClusterIP service.
3. Test DNS resolution and service access from peer namespace pod.
4. Record latency and success rate.

## Lab 2 — NetworkPolicy default deny and allow-list

### Goals

- Confirm deny-by-default behavior
- Add precise allow rules and validate expected access

### Steps

1. Apply namespace default deny ingress/egress.
2. Verify traffic block.
3. Add DNS allow egress.
4. Add app-to-app allow on required port.
5. Re-test and capture evidence.

## Lab 3 — Load and scale behavior under policy

### Goals

- Observe network behavior during pod scale-up/down
- Ensure policy remains correct during churn

### Steps

1. Drive traffic/load against target service.
2. Scale deployment or HPA.
3. Watch flow logs and policy decisions.
4. Confirm no transient policy bypass or unexpected drops.

## Lab 4 — Failure injection

### Goals

- Improve incident response readiness

### Scenarios

- DNS outage simulation
- MTU mismatch simulation
- Blocked egress dependency
- Node-local CNI agent restart

## Validation command set

```bash
kubectl get pods -A -o wide
kubectl get svc -A
kubectl get endpoints -A
kubectl get networkpolicy -A
kubectl top pods -A
```

Plugin-aware checks:

- Cilium: `cilium endpoint list`, `hubble observe --last 50`
- Calico: `calicoctl get policy -A`, `calicoctl get wep -A`

## Lab evidence template

Capture for each lab:

- Objective
- Environment details (k8s version, CNI version, node kernel)
- Commands executed
- Expected vs actual outcomes
- Logs/screenshots/metrics
- Lessons learned and follow-up actions

## Graduation criteria for production

- Connectivity and policy tests pass consistently
- Failure injection playbooks are documented and repeatable
- Team can diagnose common incidents within defined MTTR
- Upgrade rehearsal completed successfully
