# PersistentVolume (PV)

## What it is
`PersistentVolume` is a cluster-level storage resource provisioned manually or dynamically.

## When to use
- Durable data beyond Pod lifecycle
- Shared storage policy management

## Key fields
- `spec.capacity.storage`
- `spec.accessModes`: `ReadWriteOnce`, `ReadOnlyMany`, `ReadWriteMany`
- `spec.persistentVolumeReclaimPolicy`: `Retain`, `Delete`, `Recycle` (legacy)
- `spec.storageClassName`

## Common commands
```bash
kubectl get pv
kubectl describe pv pv-manual-1
kubectl delete pv pv-manual-1
```

## YAML example
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-manual-1
spec:
  capacity:
    storage: 10Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /data/pv-manual-1
```

## Practical notes
- PV is cluster-scoped; PVC is namespaced.
- Prefer dynamic provisioning with StorageClass for production.
