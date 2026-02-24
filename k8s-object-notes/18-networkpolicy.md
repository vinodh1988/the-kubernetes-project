# NetworkPolicy

## What it is
`NetworkPolicy` controls Pod-level ingress and egress traffic based on labels, namespaces, and ports.

## When to use
- Zero-trust service-to-service communication
- Restrict east-west traffic inside cluster
- Compliance and environment isolation

## Key fields
- `podSelector`: target Pods the policy applies to
- `policyTypes`: `Ingress`, `Egress`
- `ingress[]` / `egress[]`: allowed traffic rules

## Common commands
```bash
kubectl get networkpolicy -A
kubectl describe networkpolicy allow-web -n payments
kubectl apply -f networkpolicy.yaml
kubectl delete networkpolicy allow-web -n payments
```

## YAML example
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-web
  namespace: payments
spec:
  podSelector:
    matchLabels:
      app: api
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              name: ingress-nginx
      ports:
        - protocol: TCP
          port: 8080
  egress:
    - to:
        - podSelector:
            matchLabels:
              app: db
      ports:
        - protocol: TCP
          port: 5432
```

## Practical notes
- Enforcement depends on CNI plugin capability.
- Once a Pod is selected by an Ingress policy, only allowed ingress is permitted.
