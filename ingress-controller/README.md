# Ingress Controller Project

This folder contains Kubernetes manifests for:
- `nginx` Deployment with 3 replicas
- `apache` Deployment with 3 replicas
- `vinodhconnects/node-app-website` Deployment with 3 replicas (container port `3000`)
- ClusterIP Services for all three apps
- One Ingress resource to expose all three services

## Files
- `nginx-deployment.yaml`
- `apache-deployment.yaml`
- `node-app-website-deployment.yaml`
- `nginx-service.yaml`
- `apache-service.yaml`
- `node-app-website-service.yaml`
- `ingress.yaml`

## Apply

```bash
kubectl apply -f nginx-deployment.yaml
kubectl apply -f apache-deployment.yaml
kubectl apply -f node-app-website-deployment.yaml
kubectl apply -f nginx-service.yaml
kubectl apply -f apache-service.yaml
kubectl apply -f node-app-website-service.yaml
kubectl apply -f ingress.yaml
```

Or apply all at once:

```bash
kubectl apply -f .
```

## Ingress paths
- `/nginx` -> `nginx-service:80`
- `/apache` -> `apache-service:80`
- `/node` -> `node-app-website-service:3000`

## Verify

```bash
kubectl get deploy,svc,ingress
```

If you are using NGINX Ingress Controller, ensure it is installed and running before applying `ingress.yaml`.
