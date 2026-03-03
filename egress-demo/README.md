# Kubernetes Egress Demo Project

## Goal
Demonstrate how to control **outbound (egress) traffic** from Pods using `NetworkPolicy`.

This demo shows a practical sequence:
- start with normal connectivity
- apply **deny-all egress**
- re-allow only what is needed (DNS + specific internal destination)

---

## Project structure

```text
egress-demo/
  README.md
  manifests/
    00-namespace.yaml
    01-apps-services.yaml
    02-deny-all-egress.yaml
    03-allow-dns-egress.yaml
    04-allow-internal-egress.yaml
```

---

## How this demo works

- `egress-client`: pod used to test outbound traffic (`curlimages/curl`)
- `echo-server` + `echo-svc`: internal destination inside same namespace
- `deny-all-egress`: blocks all outbound traffic for all pods in namespace
- `allow-dns-egress`: allows DNS lookups to CoreDNS
- `allow-egress-to-echo`: allows `egress-client` to reach only `echo-server:5678`

---

## Prerequisites

- Running Kubernetes cluster
- `kubectl` configured
- CNI plugin with `NetworkPolicy` enforcement (Calico, Cilium, Antrea, etc.)

Check quickly:

```bash
kubectl api-resources | findstr networkpolicies
```

If policies exist but enforcement is not supported by your CNI, traffic behavior may not change.

---

## Step 1: Deploy namespace and workloads

```bash
kubectl apply -f egress-demo/manifests/00-namespace.yaml
kubectl apply -f egress-demo/manifests/01-apps-services.yaml
```

Verify:

```bash
kubectl get deploy,pods,svc -n egress-demo
```

---

## Step 2: Baseline connectivity tests (before policy)

Internal service call (should work):

```bash
kubectl exec -n egress-demo deploy/egress-client -- sh -c "curl -sS --connect-timeout 3 http://echo-svc:5678"
```

External call (usually works before policy):

```bash
kubectl exec -n egress-demo deploy/egress-client -- sh -c "curl -I --connect-timeout 5 https://example.com"
```

---

## Step 3: Apply deny-all egress

```bash
kubectl apply -f egress-demo/manifests/02-deny-all-egress.yaml
kubectl get networkpolicy -n egress-demo
```

Re-test from `egress-client`:

```bash
kubectl exec -n egress-demo deploy/egress-client -- sh -c "curl -sS --connect-timeout 3 http://echo-svc:5678"
kubectl exec -n egress-demo deploy/egress-client -- sh -c "curl -I --connect-timeout 5 https://example.com"
```

Expected: both requests fail (all egress blocked).

---

## Step 4: Allow DNS + specific internal egress

Apply allow policies:

```bash
kubectl apply -f egress-demo/manifests/03-allow-dns-egress.yaml
kubectl apply -f egress-demo/manifests/04-allow-internal-egress.yaml
kubectl get networkpolicy -n egress-demo
```

Re-test:

```bash
kubectl exec -n egress-demo deploy/egress-client -- sh -c "curl -sS --connect-timeout 3 http://echo-svc:5678"
kubectl exec -n egress-demo deploy/egress-client -- sh -c "curl -I --connect-timeout 5 https://example.com"
```

Expected:
- internal call to `echo-svc:5678` works
- external internet call still fails (not explicitly allowed)

---

## Useful debug commands

```bash
kubectl describe networkpolicy deny-all-egress -n egress-demo
kubectl describe networkpolicy allow-dns-egress -n egress-demo
kubectl describe networkpolicy allow-egress-to-echo -n egress-demo
kubectl get pods -n kube-system -l k8s-app=kube-dns
kubectl get events -n egress-demo --sort-by=.lastTimestamp
```

---

## Cleanup

```bash
kubectl delete -f egress-demo/manifests/04-allow-internal-egress.yaml --ignore-not-found=true
kubectl delete -f egress-demo/manifests/03-allow-dns-egress.yaml --ignore-not-found=true
kubectl delete -f egress-demo/manifests/02-deny-all-egress.yaml --ignore-not-found=true
kubectl delete -f egress-demo/manifests/01-apps-services.yaml --ignore-not-found=true
kubectl delete -f egress-demo/manifests/00-namespace.yaml --ignore-not-found=true
```
