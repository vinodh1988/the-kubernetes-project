# Namespace

## What it is
`Namespace` is a logical isolation boundary inside a cluster. It separates resources, policies, and quotas for teams or environments.

## When to use
- Multi-team clusters (`team-a`, `team-b`)
- Environment separation (`dev`, `stage`, `prod`)
- Applying `ResourceQuota`, `LimitRange`, and RBAC per boundary

## Key fields
- `metadata.name`: namespace name
- `metadata.labels`: grouping and policy selectors

## Common commands
```bash
kubectl get ns
kubectl create namespace payments
kubectl label namespace payments owner=platform env=prod
kubectl config set-context --current --namespace=payments
kubectl get all -n payments
kubectl delete namespace payments
```

## YAML example
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: payments
  labels:
    owner: platform
    env: prod
```

## Practical notes
- Most namespaced objects (Pods, Deployments, Services) must live in a namespace.
- Cluster-wide objects (Nodes, PVs, StorageClasses) are not namespaced.
- Namespace deletion is asynchronous and removes all namespaced objects in it.
