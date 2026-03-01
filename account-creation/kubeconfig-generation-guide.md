# Kubeconfig Generation Guide (ServiceAccount + RBAC)

Creating a `ServiceAccount`, `Role`/`ClusterRole`, and bindings gives you identity + permissions.

It does **not** automatically create a standalone kubeconfig file for client use.

Use the commands below to generate kubeconfig automatically.

## Prerequisites

- Namespace: `account-creation`
- ServiceAccount: `account-creation-user`
- `kubectl` connected to your cluster with admin access

## Auto-generate kubeconfig (Linux/macOS/Git Bash)

```bash
TOKEN=$(kubectl -n account-creation create token account-creation-user)
SERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
CA=$(kubectl config view --raw --minify -o jsonpath='{.clusters[0].cluster.certificate-authority-data}')

kubectl config set-cluster target-cluster \
  --server="$SERVER" \
  --certificate-authority-data="$CA" \
  --kubeconfig=account-creation-user.kubeconfig

kubectl config set-credentials account-creation-user \
  --token="$TOKEN" \
  --kubeconfig=account-creation-user.kubeconfig

kubectl config set-context account-creation-user@target-cluster \
  --cluster=target-cluster \
  --user=account-creation-user \
  --namespace=account-creation \
  --kubeconfig=account-creation-user.kubeconfig

kubectl config use-context account-creation-user@target-cluster \
  --kubeconfig=account-creation-user.kubeconfig
```

## Auto-generate kubeconfig (Windows CMD)

```cmd
for /f "delims=" %i in ('kubectl -n account-creation create token account-creation-user') do set TOKEN=%i
for /f "delims=" %i in ('kubectl config view --minify -o jsonpath="{.clusters[0].cluster.server}"') do set SERVER=%i
for /f "delims=" %i in ('kubectl config view --raw --minify -o jsonpath="{.clusters[0].cluster.certificate-authority-data}"') do set CA=%i

kubectl config set-cluster target-cluster --server="%SERVER%" --certificate-authority-data="%CA%" --kubeconfig=account-creation-user.kubeconfig
kubectl config set-credentials account-creation-user --token="%TOKEN%" --kubeconfig=account-creation-user.kubeconfig
kubectl config set-context account-creation-user@target-cluster --cluster=target-cluster --user=account-creation-user --namespace=account-creation --kubeconfig=account-creation-user.kubeconfig
kubectl config use-context account-creation-user@target-cluster --kubeconfig=account-creation-user.kubeconfig
```

## Validate permissions

```bash
kubectl --kubeconfig=account-creation-user.kubeconfig get pods -A
kubectl --kubeconfig=account-creation-user.kubeconfig auth can-i create deployment -n default
kubectl --kubeconfig=account-creation-user.kubeconfig auth can-i create deployment -n account-creation
```

Expected:
- Read across namespaces: allowed
- Write in `default` (or other namespaces): denied
- Write in `account-creation`: allowed

## Important note

`kubectl create token` returns a token that may expire depending on cluster configuration.
If it expires, create a new token and update the kubeconfig user token.
