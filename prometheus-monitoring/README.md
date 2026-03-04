# Prometheus + Grafana Monitoring on Kubernetes

This project provides a step-by-step setup for installing Prometheus and Grafana on a Kubernetes cluster using Helm.

## Architecture

The installation uses `kube-prometheus-stack`, which includes:
- Prometheus
- Grafana
- Alertmanager
- node-exporter
- kube-state-metrics

## Prerequisites

- Kubernetes cluster (multi-node, kubeadm, managed cluster, or Minikube)
- `kubectl` configured and connected to your cluster
- `helm` installed
- Optional for Minikube:

```bash
minikube addons enable metrics-server
```

## Step 1: Add the Helm repository

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

## Step 2: Create a namespace

```bash
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -
```

## Step 3: Install Prometheus + Grafana

```bash
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack -n monitoring
```

## Step 4: Verify all monitoring pods

```bash
kubectl get pods -n monitoring
```

Wait until pods are ready (`Running`/`Completed`).

## Step 5: Identify Grafana and Prometheus services

Service names can vary by chart version/release name:

```bash
kubectl get svc -n monitoring
kubectl get svc -n monitoring | findstr grafana
kubectl get svc -n monitoring | findstr prometheus
```

Common defaults:
- `monitoring-grafana`
- `monitoring-kube-prometheus-prometheus`

## Step 6: Access dashboards

### Option A (recommended): Port-forward

Grafana:

```bash
kubectl -n monitoring port-forward svc/monitoring-grafana 3000:80
```

Prometheus:

```bash
kubectl -n monitoring port-forward svc/monitoring-kube-prometheus-prometheus 9090:9090
```

Open in browser:
- Grafana: http://localhost:3000
- Prometheus: http://localhost:9090

### Option B: Minikube URL

```bash
minikube service -n monitoring monitoring-grafana --url
minikube service -n monitoring monitoring-kube-prometheus-prometheus --url
```

### Option C: NodePort (bare-metal labs)

```bash
kubectl -n monitoring patch svc monitoring-grafana -p '{"spec":{"type":"NodePort"}}'
kubectl -n monitoring get svc monitoring-grafana -o wide
```

Then open:

```text
http://<NODE_IP>:<NODE_PORT>
```

## Step 7: Grafana login

Username:

```text
admin
```

Get password:

```bash
kubectl get secret -n monitoring monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```

## Step 8: Quick validation

```bash
kubectl get pods -n monitoring
kubectl get svc -n monitoring
kubectl top nodes
kubectl top pods -A
```

If `kubectl top` fails, ensure `metrics-server` is installed and running.

## Uninstall

```bash
helm uninstall monitoring -n monitoring
kubectl delete namespace monitoring
```
