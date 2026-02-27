# helm-hpa

Helm version of the previous `hpa-demo` project.

## What this chart deploys

- App deployment: `hpa-web`
- Service: `hpa-web-svc`
- HPA (`autoscaling/v2`) targeting CPU utilization
- Optional load generator deployment (`load-generator`) for scale-up demo

## Prerequisites

- Kubernetes cluster
- `kubectl` and `helm`
- Metrics pipeline (typically `metrics-server`)

## Install

```bash
helm upgrade --install helm-hpa ./helm-hpa -n hpa-demo --create-namespace
```

## Verify

```bash
kubectl get deploy,hpa,pods -n hpa-demo
kubectl describe hpa hpa-web -n hpa-demo
```

## Start load (scale up)

Enable load generator:

```bash
helm upgrade --install helm-hpa ./helm-hpa -n hpa-demo --set loadGenerator.enabled=true
```

Watch:

```bash
kubectl get hpa hpa-web -n hpa-demo -w
kubectl get deploy hpa-web -n hpa-demo -w
```

## Stop load (scale down)

Disable load generator:

```bash
helm upgrade --install helm-hpa ./helm-hpa -n hpa-demo --set loadGenerator.enabled=false
```

## Uninstall

```bash
helm uninstall helm-hpa -n hpa-demo
kubectl delete ns hpa-demo --ignore-not-found=true
```
