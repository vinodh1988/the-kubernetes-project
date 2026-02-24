# StatefulSet

## What it is
`StatefulSet` manages stateful Pods with stable identity and stable storage.

## When to use
- Databases, queues, distributed systems
- Ordered startup/shutdown requirements
- Persistent data per replica

## Key fields
- `spec.serviceName`: headless service for network identity
- `spec.replicas`: number of instances
- `spec.volumeClaimTemplates[]`: per-Pod PVC template
- `spec.podManagementPolicy`: `OrderedReady` or `Parallel`

## Common commands
```bash
kubectl get statefulset
kubectl describe statefulset postgres
kubectl scale statefulset postgres --replicas=3
kubectl rollout status statefulset/postgres
kubectl delete statefulset postgres
```

## YAML example
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgres
spec:
  serviceName: postgres-headless
  replicas: 2
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres
          image: postgres:16
          env:
            - name: POSTGRES_PASSWORD
              value: change-me
          volumeMounts:
            - name: data
              mountPath: /var/lib/postgresql/data
  volumeClaimTemplates:
    - metadata:
        name: data
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 10Gi
```

## Practical notes
- Pod names are ordinal (`postgres-0`, `postgres-1`).
- Deleting StatefulSet does not automatically delete bound PVCs unless separately configured.
