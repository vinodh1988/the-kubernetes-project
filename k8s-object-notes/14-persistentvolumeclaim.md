# PersistentVolumeClaim (PVC)

## What it is
`PersistentVolumeClaim` requests storage for workloads.

## When to use
- Any stateful workload needing persistent disk
- Decouple app from underlying storage implementation

## Key fields
- `spec.resources.requests.storage`
- `spec.accessModes`
- `spec.storageClassName`
- `spec.volumeName` (optional explicit binding)

## Common commands
```bash
kubectl get pvc
kubectl describe pvc app-data
kubectl delete pvc app-data
```

## YAML example
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: app-data
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: standard
  resources:
    requests:
      storage: 5Gi
```

## Pod mount example
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app-with-pvc
spec:
  containers:
    - name: app
      image: nginx:1.27
      volumeMounts:
        - name: data
          mountPath: /usr/share/nginx/html
  volumes:
    - name: data
      persistentVolumeClaim:
        claimName: app-data
```

## Practical notes
- PVC stays bound across Pod reschedules.
- Deleting PVC behavior depends on PV reclaim policy.
