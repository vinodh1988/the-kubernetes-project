
# Kubernetes Monitoring Setup (Multi-Node + Minikube)

## Goal
Set up cluster monitoring with:
- Prometheus
- Grafana
- Alertmanager
- Node Exporter + kube-state-metrics

This guide uses the Helm chart `kube-prometheus-stack`.

---

## Prerequisites
- Kubernetes cluster (multi-node or Minikube)
- `kubectl` configured
- `helm` installed
- In Minikube, make sure addons are enabled:

```bash
minikube addons enable metrics-server
```

---

## 1) Install monitoring stack

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack -n monitoring
```

Wait until pods are ready:

```bash
kubectl get pods -n monitoring
```

---

## 2) Find service names (important)

Service names can vary by chart version/release. Discover them first:

```bash
kubectl get svc -n monitoring
kubectl get svc -n monitoring | findstr grafana
kubectl get svc -n monitoring | findstr prometheus
```

Use the discovered Grafana and Prometheus service names in the access commands below.

---

## 3) Access monitoring UI in a multi-node cluster

### Option A (recommended): Port-forward (works everywhere)

Grafana:

```bash
kubectl -n monitoring port-forward svc/monitoring-grafana 3000:80
```

Prometheus:

```bash
kubectl -n monitoring port-forward svc/monitoring-kube-prometheus-prometheus 9090:9090
```

Open:
- Grafana: http://localhost:3000
- Prometheus: http://localhost:9090

### Option B: Expose via NodePort (for local bare-metal labs)

```bash
kubectl -n monitoring patch svc monitoring-grafana -p '{"spec":{"type":"NodePort"}}'
kubectl -n monitoring get svc monitoring-grafana -o wide
```

Access Grafana:

```text
http://<ANY_NODE_IP>:<NODE_PORT>
```

> If your cluster supports LoadBalancer (cloud), you can expose Grafana as `LoadBalancer` instead of `NodePort`.

---

## 4) Access monitoring UI in Minikube

Use Minikube service tunnel URLs:

```bash
minikube service -n monitoring monitoring-grafana --url
minikube service -n monitoring monitoring-kube-prometheus-prometheus --url
```

Alternative (also valid in Minikube):

```bash
kubectl -n monitoring port-forward svc/monitoring-grafana 3000:80
kubectl -n monitoring port-forward svc/monitoring-kube-prometheus-prometheus 9090:9090
```

---

## 5) Grafana login

Default username:

```text
admin
```

Get password from secret:

```bash
kubectl get secret -n monitoring monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```

---

## 6) Quick verification

```bash
kubectl get pods -n monitoring
kubectl get svc -n monitoring
kubectl top nodes
kubectl top pods -A
```

If `kubectl top` fails, ensure your metrics pipeline is running (`metrics-server`).

---

## 7) Uninstall

```bash
helm uninstall monitoring -n monitoring
kubectl delete namespace monitoring
```
