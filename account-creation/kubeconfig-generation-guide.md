# Kubeconfig Generation Guide (ServiceAccount + RBAC)

Creating a `ServiceAccount`, `Role`/`ClusterRole`, and bindings gives you identity + permissions.

It does **not** automatically create a standalone kubeconfig file for client use.

Use the commands below to generate kubeconfig automatically.

## Linux quick path (recommended for you)

Use only the following commands on Linux:

```bash
kubectl config view --raw --minify --flatten > account-creation-user.kubeconfig
TOKEN=$(kubectl -n account-creation create token account-creation-user)

kubectl --kubeconfig=account-creation-user.kubeconfig config set-credentials account-creation-user --token="$TOKEN"
kubectl --kubeconfig=account-creation-user.kubeconfig config set-context --current --user=account-creation-user --namespace=account-creation

kubectl --kubeconfig=account-creation-user.kubeconfig get pods -A
kubectl --kubeconfig=account-creation-user.kubeconfig auth can-i create deployment -n default
kubectl --kubeconfig=account-creation-user.kubeconfig auth can-i create deployment -n account-creation
```

## Prerequisites

- Namespace: `account-creation`
- ServiceAccount: `account-creation-user`
- `kubectl` connected to your cluster with admin access

## Auto-generate kubeconfig (Linux/macOS/Git Bash)

Run only this section in Bash/Git Bash (do not run Windows CMD commands here).

```bash
kubectl config view --raw --minify --flatten > account-creation-user.kubeconfig
TOKEN=$(kubectl -n account-creation create token account-creation-user)

kubectl --kubeconfig=account-creation-user.kubeconfig config set-credentials account-creation-user --token="$TOKEN"

kubectl --kubeconfig=account-creation-user.kubeconfig config set-context --current \
  --user=account-creation-user \
  --namespace=account-creation
```

## Auto-generate kubeconfig (Windows CMD)

Skip this section if you are on Linux.

Run only this section in `cmd.exe` (do not run Bash commands here).

```cmd
kubectl config view --raw --minify --flatten > account-creation-user.kubeconfig
for /f "delims=" %i in ('kubectl -n account-creation create token account-creation-user') do set TOKEN=%i

kubectl --kubeconfig=account-creation-user.kubeconfig config set-credentials account-creation-user --token="%TOKEN%"
kubectl --kubeconfig=account-creation-user.kubeconfig config set-context --current --user=account-creation-user --namespace=account-creation
```

## Why this works

- `kubectl config view --raw --minify --flatten` copies server + CA details from your current context.
- Then the commands only inject ServiceAccount token and namespace/user.
- This avoids `--certificate-authority-data`, which is unsupported in some `kubectl` versions.

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
