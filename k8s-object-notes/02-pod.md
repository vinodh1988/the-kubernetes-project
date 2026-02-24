# Pod

## What it is
`Pod` is the smallest deployable unit in Kubernetes. A Pod wraps one or more tightly coupled containers sharing network namespace and storage volumes.

## When to use
- Direct debugging or one-off workloads
- Sidecar patterns (app + log shipper/proxy)
- Usually managed by higher-level controllers (Deployment, Job)

## Key fields
- `spec.containers[]`: container definitions
- `spec.restartPolicy`: `Always`, `OnFailure`, `Never`
- `spec.volumes[]`: shared storage for containers
- `spec.nodeSelector` / `affinity` / `tolerations`: scheduling control

## Common commands
```bash
kubectl get pods -A
kubectl run nginx-pod --image=nginx:1.27 --restart=Never
kubectl describe pod nginx-pod
kubectl logs nginx-pod
kubectl logs -f nginx-pod
kubectl exec -it nginx-pod -- sh
kubectl delete pod nginx-pod
```

## YAML example
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: api-pod
  labels:
    app: api
spec:
  containers:
    - name: api
      image: nginx:1.27
      ports:
        - containerPort: 80
      resources:
        requests:
          cpu: "100m"
          memory: "128Mi"
        limits:
          cpu: "300m"
          memory: "256Mi"
```

## Practical notes
- Pod IP is ephemeral; use a `Service` for stable networking.
- Standalone Pods are not self-healing after node loss.
