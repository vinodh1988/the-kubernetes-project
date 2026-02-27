# Kustomize Installation Guide

## Goal
Install and verify Kustomize on Windows, Linux, or macOS.

---

## Option A (recommended): use `kubectl` built-in Kustomize

Most recent `kubectl` versions already support Kustomize commands.

Check versions:

```bash
kubectl version --client
kubectl kustomize --help
```

If `kubectl kustomize --help` works, you can use this demo without a separate `kustomize` binary.

---

## Option B: install standalone `kustomize` binary

### Windows (winget)

```powershell
winget install Kubernetes.kustomize
```

Then verify:

```powershell
kustomize version
```

### Windows (choco)

```powershell
choco install kustomize -y
```

Verify:

```powershell
kustomize version
```

### Linux (script from upstream)

```bash
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
sudo mv kustomize /usr/local/bin/
kustomize version
```

### macOS (Homebrew)

```bash
brew install kustomize
kustomize version
```

---

## Verify local setup for this project

From repo root:

```bash
kubectl kustomize kustomize-e2e-demo/overlays/dev
kubectl kustomize kustomize-e2e-demo/overlays/prod
```

If both commands render YAML successfully, installation is complete.

---

## Troubleshooting

1. `kustomize` command not found
   - Reopen terminal or ensure install path is in `PATH`.

2. `kubectl kustomize` not recognized
   - Upgrade `kubectl` to a recent version.

3. `kubectl` cannot connect to cluster
   - Confirm context with:

```bash
kubectl config get-contexts
kubectl config current-context
kubectl get nodes
```
