# Azure PVC Project (Non-AKS Azure Disk)

## Goal
Demonstrate how to use **Azure Disk** as persistent storage in Kubernetes using a `StorageClass` + `PersistentVolumeClaim`.

This project uses dynamic provisioning with CSI provisioner `disk.csi.azure.com`.

---

## Project structure

```text
azure-pvc/
  README.md
  manifests/
    00-namespace.yaml
    01-storageclass.yaml
    02-pvc.yaml
    03-deployment.yaml
    04-service.yaml
```

---

## Prerequisites

- Kubernetes cluster with **Azure Disk CSI driver** installed (`disk.csi.azure.com`)
- Cluster nodes running on Azure infrastructure with permissions to create/attach managed disks
- `kubectl` connected to your cluster

Check available CSI driver and storage classes:

```bash
kubectl get csidriver
kubectl get storageclass
```

You should see `disk.csi.azure.com` in CSI drivers.

If your cluster is **not on Azure VMs** (for example local KIND/Minikube on laptop), Azure Disk cannot be attached directly.

---

## Step 1: Apply manifests

From repo root:

```bash
kubectl apply -f azure-pvc/manifests/00-namespace.yaml
kubectl apply -f azure-pvc/manifests/01-storageclass.yaml
kubectl apply -f azure-pvc/manifests/02-pvc.yaml
kubectl apply -f azure-pvc/manifests/03-deployment.yaml
kubectl apply -f azure-pvc/manifests/04-service.yaml
```

---

## Step 2: Validate PVC and pod

```bash
kubectl get pvc,pv -n azure-pvc
kubectl get pods,svc -n azure-pvc
kubectl describe pvc azure-disk-pvc -n azure-pvc
```

Expected:
- PVC status: `Bound`
- A PV is auto-created and bound to the claim
- Deployment pod is `Running`

---

## Step 3: Write data and verify persistence

Write a file inside the mounted disk:

```bash
kubectl exec -n azure-pvc deploy/azure-disk-app -- sh -c 'echo "hello from azure disk" > /usr/share/nginx/html/index.html'
kubectl exec -n azure-pvc deploy/azure-disk-app -- cat /usr/share/nginx/html/index.html
```

Restart pod and re-check:

```bash
kubectl rollout restart deploy/azure-disk-app -n azure-pvc
kubectl rollout status deploy/azure-disk-app -n azure-pvc
kubectl exec -n azure-pvc deploy/azure-disk-app -- cat /usr/share/nginx/html/index.html
```

If the same content is present after restart, persistence is working.

---

## Important notes

- Azure Disk is typically `ReadWriteOnce` (attach to one node at a time).
- For multi-pod multi-node shared access (`ReadWriteMany`), use Azure Files instead.
- `StorageClass` in this demo uses `StandardSSD_LRS`; change `skuName` in `azure-pvc/manifests/01-storageclass.yaml` if needed.
- If your cluster is not Azure-backed, use another storage backend (NFS, Ceph, local-path, cloud-specific CSI).

---

## Cleanup

```bash
kubectl delete -f azure-pvc/manifests/04-service.yaml
kubectl delete -f azure-pvc/manifests/03-deployment.yaml
kubectl delete -f azure-pvc/manifests/02-pvc.yaml
kubectl delete -f azure-pvc/manifests/01-storageclass.yaml
kubectl delete -f azure-pvc/manifests/00-namespace.yaml
```
