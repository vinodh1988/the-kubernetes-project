# ReplicaSet

## What it is
`ReplicaSet` ensures a stable number of Pod replicas are running.

## When to use
- Usually indirectly through `Deployment`
- Rare direct usage in special control scenarios

## Key fields
- `spec.replicas`: desired count
- `spec.selector`: target Pods
- `spec.template`: Pod blueprint if Pods need recreation

## Common commands
```bash
kubectl get rs
kubectl describe rs web-rs
kubectl scale rs web-rs --replicas=5
kubectl delete rs web-rs
```

## YAML example
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: web-rs
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web-rs
  template:
    metadata:
      labels:
        app: web-rs
    spec:
      containers:
        - name: web
          image: nginx:1.27
```

## Practical notes
- If both Deployment and direct ReplicaSet manage similar labels, they can conflict.
- Prefer Deployment for versioned rollouts and rollback history.
