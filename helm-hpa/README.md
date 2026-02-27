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
helm upgrade --install helm-hpa ./helm-hpa -n helm-hpa --create-namespace
```

## Verify

```bash
kubectl get deploy,hpa,pods -n helm-hpa
kubectl describe hpa hpa-web -n helm-hpa
```

## Start load (scale up)

Enable load generator:

```bash
helm upgrade --install helm-hpa ./helm-hpa -n helm-hpa --set loadGenerator.enabled=true
```

Watch:

```bash
kubectl get hpa hpa-web -n helm-hpa -w
kubectl get deploy hpa-web -n helm-hpa -w
```

## Stop load (scale down)

Disable load generator:

```bash
helm upgrade --install helm-hpa ./helm-hpa -n helm-hpa --set loadGenerator.enabled=false
```

## Uninstall

```bash
helm uninstall helm-hpa -n helm-hpa
kubectl delete ns helm-hpa --ignore-not-found=true
```
