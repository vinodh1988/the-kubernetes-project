# Kubernetes Major Objects Notes

This folder provides separate notes for the most common Kubernetes objects, each including:
- Purpose and usage guidance
- Important fields to remember
- `kubectl` command examples
- Ready-to-apply YAML manifests

## Recommended learning order
1. Namespace
2. Pod
3. Deployment
4. ReplicaSet
5. Service
6. Ingress
7. ConfigMap
8. Secret
9. Job
10. CronJob
11. StatefulSet
12. DaemonSet
13. PersistentVolume
14. PersistentVolumeClaim
15. StorageClass
16. ServiceAccount + RBAC
17. HorizontalPodAutoscaler
18. NetworkPolicy
19. MetalLB

## File list
- `01-namespace.md`
- `02-pod.md`
- `03-deployment.md`
- `04-replicaset.md`
- `05-statefulset.md`
- `06-daemonset.md`
- `07-job.md`
- `08-cronjob.md`
- `09-service.md`
- `10-ingress.md`
- `11-configmap.md`
- `12-secret.md`
- `13-persistentvolume.md`
- `14-persistentvolumeclaim.md`
- `15-storageclass.md`
- `16-serviceaccount-rbac.md`
- `17-horizontalpodautoscaler.md`
- `18-networkpolicy.md`
- `19-metallb.md`

## Quick usage
```bash
kubectl apply -f <file>.yaml
kubectl get all -n <namespace>
kubectl describe <kind> <name>
```
