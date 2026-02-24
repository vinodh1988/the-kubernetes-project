# Config + Secrets Project

This folder contains Kubernetes manifests for `vinodhconnects/node-app-website` with:
- 1 ConfigMap (5 environment variables)
- 1 Secret (4 sensitive values)
- 1 Deployment consuming both ConfigMap and Secret
- 1 Service exposing the app on port `3000`

## Files
- `01-configmap.yaml`
- `02-secret.yaml`
- `03-deployment.yaml`
- `04-service.yaml`

## Apply

```bash
kubectl apply -f .
```

## Verify

```bash
kubectl get configmap,secret,deploy,svc
kubectl describe deploy node-app-website-deployment
```