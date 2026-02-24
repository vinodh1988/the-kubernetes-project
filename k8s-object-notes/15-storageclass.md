# StorageClass

## What it is
`StorageClass` defines dynamic provisioning parameters for persistent storage.

## When to use
- Standardize storage tiers (fast/slow, SSD/HDD)
- Enable dynamic PV creation from PVC requests

## Key fields
- `provisioner`: CSI driver identity
- `parameters`: backend-specific config
- `reclaimPolicy`: default PV reclaim behavior
- `volumeBindingMode`: `Immediate` or `WaitForFirstConsumer`

## Common commands
```bash
kubectl get storageclass
kubectl describe storageclass standard
kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

## YAML example
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-ssd
provisioner: ebs.csi.aws.com
parameters:
  type: gp3
reclaimPolicy: Delete
allowVolumeExpansion: true
volumeBindingMode: WaitForFirstConsumer
```

## Practical notes
- `WaitForFirstConsumer` helps topology-aware placement.
- Keep one clear default StorageClass unless intentionally multi-default.
