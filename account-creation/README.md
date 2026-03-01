# Account Creation RBAC Project

This project creates RBAC for a Kubernetes identity with these permissions:

- **Read-only on all namespaces** (`get`, `list`, `watch`)
- **Full access on project namespace** (`account-creation`)

## Files

- `manifests/00-namespace.yaml`
- `manifests/01-serviceaccount.yaml`
- `manifests/02-clusterrole-read-all-ns.yaml`
- `manifests/03-clusterrolebinding-read-all-ns.yaml`
- `manifests/04-role-full-project-ns.yaml`
- `manifests/05-rolebinding-full-project-ns.yaml`
- `account-creation-user.kubeconfig.template`

## 1) Create project namespace

```bash
kubectl create namespace account-creation
```

If it already exists, skip this and continue.

## 2) Apply all manifests

```bash
kubectl apply -f manifests/
```

## 3) Verify access

### Read in any namespace should be allowed

```bash
kubectl auth can-i list pods --as=system:serviceaccount:account-creation:account-creation-user -n kube-system
kubectl auth can-i get deployments --as=system:serviceaccount:account-creation:account-creation-user -n default
```

### Write in other namespaces should be denied

```bash
kubectl auth can-i create deployment --as=system:serviceaccount:account-creation:account-creation-user -n default
```

### Full access in project namespace should be allowed

```bash
kubectl auth can-i create deployment --as=system:serviceaccount:account-creation:account-creation-user -n account-creation
kubectl auth can-i delete service --as=system:serviceaccount:account-creation:account-creation-user -n account-creation
```

## 4) Generate credentials for this account (token)

```bash
kubectl -n account-creation create token account-creation-user
```

Use this token in a kubeconfig/user context if needed.

## 5) Create kubeconfig from template

Template file:

- `account-creation-user.kubeconfig.template`

Collect values:

```bash
# API server URL
kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}'

# Cluster CA in base64
kubectl config view --raw --minify -o jsonpath='{.clusters[0].cluster.certificate-authority-data}'

# ServiceAccount token
kubectl -n account-creation create token account-creation-user
```

Replace placeholders in template:

- `<API_SERVER_HOST>` (or replace full `server:` line directly)
- `<BASE64_CA_CRT>`
- `<SERVICE_ACCOUNT_TOKEN>`

Then use the kubeconfig:

```bash
kubectl --kubeconfig ./account-creation-user.kubeconfig.template get pods -A
kubectl --kubeconfig ./account-creation-user.kubeconfig.template auth can-i create deployment -n default
kubectl --kubeconfig ./account-creation-user.kubeconfig.template auth can-i create deployment -n account-creation
```
