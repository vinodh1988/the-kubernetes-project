# DaemonSet

## What it is
`DaemonSet` runs exactly one Pod copy (or configured pattern) on each eligible node.

## When to use
- Node agents: log collectors, monitoring, CNI helpers
- Security agents that must run on all nodes

## Key fields
- `spec.selector` and `spec.template`
- `spec.template.spec.nodeSelector` / `tolerations`
- `spec.updateStrategy`: rolling behavior across nodes

## Common commands
```bash
kubectl get daemonset -A
kubectl describe daemonset fluent-bit -n kube-system
kubectl rollout status daemonset/fluent-bit -n kube-system
kubectl delete daemonset fluent-bit -n kube-system
```

## YAML example
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-exporter
  namespace: monitoring
spec:
  selector:
    matchLabels:
      app: node-exporter
  template:
    metadata:
      labels:
        app: node-exporter
    spec:
      tolerations:
        - operator: Exists
      containers:
        - name: exporter
          image: prom/node-exporter:v1.8.2
          ports:
            - name: metrics
              containerPort: 9100
```

## Practical notes
- New nodes automatically get the DaemonSet Pod.
- Exclude nodes with taints/labels when needed.
