# Helm Full Tutorial

This guide takes you from Helm basics to real project workflows: creating charts, understanding structure, using repositories, working with OCI registries, packaging, publishing, and deploying.

## 1) What Helm Is

Helm is the package manager for Kubernetes.

- A **Chart** is a versioned package of Kubernetes manifests.
- A **Release** is an installed instance of a chart in a cluster.
- A chart can be configured through `values.yaml` and override files.

---

## 2) Prerequisites

- Kubernetes cluster access (`kubectl` configured)
- Helm installed (v3+)
- Optional: Docker/OCI registry access for chart publishing

Check versions:

```bash
helm version
kubectl version --client
```

---

## 3) Install Helm

### Windows (winget)

```powershell
winget install Helm.Helm
```

### macOS (Homebrew)

```bash
brew install helm
```

### Linux (script)

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

---

## 4) Create a Helm Project (Chart)

Create a new chart:

```bash
helm create myapp
```

You now have a Helm chart project in `myapp/`.

Lint and render locally:

```bash
helm lint myapp
helm template myapp ./myapp
```

Install to cluster:

```bash
helm install myapp-release ./myapp -n demo --create-namespace
```

---

## 5) Helm Project Structure

Typical output of `helm create myapp`:

```text
myapp/
  Chart.yaml
  values.yaml
  charts/
  templates/
    _helpers.tpl
    deployment.yaml
    service.yaml
    serviceaccount.yaml
    hpa.yaml
    ingress.yaml
    tests/
      test-connection.yaml
```

### Important files

- `Chart.yaml`: chart metadata (name, version, dependencies)
- `values.yaml`: default configuration values
- `templates/`: Kubernetes manifests with Helm template syntax
- `templates/_helpers.tpl`: reusable template helpers
- `charts/`: vendored dependency charts (if not pulled dynamically)

---

## 6) Core Helm Commands (Day-to-Day)

```bash
# validate
helm lint ./myapp

# render templates without installing
helm template myapp-release ./myapp -f values.yaml

# install
helm install myapp-release ./myapp -n demo --create-namespace

# upgrade (or install if missing)
helm upgrade --install myapp-release ./myapp -n demo -f values-prod.yaml

# view release status/history
helm status myapp-release -n demo
helm history myapp-release -n demo

# rollback
helm rollback myapp-release 1 -n demo

# uninstall
helm uninstall myapp-release -n demo
```

---

## 7) Values and Environment Overlays

Use defaults in `values.yaml`, then override per environment:

```bash
helm upgrade --install myapp-release ./myapp \
  -n demo \
  -f values.yaml \
  -f values-dev.yaml
```

Precedence (highest to lowest):

1. `--set` / `--set-string`
2. Later `-f` files
3. Earlier `-f` files
4. `values.yaml`

Example:

```bash
helm upgrade --install myapp-release ./myapp -n demo --set image.tag=1.2.3
```

---

## 8) Templating Essentials

Useful template patterns in `templates/*.yaml`:

```yaml
image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"

replicas: {{ .Values.replicaCount }}

{{- if .Values.ingress.enabled }}
# ingress block
{{- end }}
```

Use helper templates in `_helpers.tpl` for names/labels reuse.

---

## 9) Chart Dependencies (Project Composition)

In `Chart.yaml`:

```yaml
dependencies:
  - name: redis
    version: 18.17.0
    repository: https://charts.bitnami.com/bitnami
```

Fetch dependencies:

```bash
helm dependency update ./myapp
```

This updates `charts/` and `Chart.lock`.

---

## 10) Repositories (Classic Helm Repos)

Add/search/update repos:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo nginx
```

Install from repo:

```bash
helm install nginx bitnami/nginx -n web --create-namespace
```

Package your chart:

```bash
helm package ./myapp
# produces myapp-<version>.tgz
```

---

## 11) Registries (OCI-Based Charts)

Helm supports OCI registries (recommended for many teams).

Enable (for older Helm versions only; new versions are OCI-ready):

```bash
export HELM_EXPERIMENTAL_OCI=1
```

Login:

```bash
helm registry login ghcr.io -u <username>
```

Package and push:

```bash
helm package ./myapp
helm push myapp-0.1.0.tgz oci://ghcr.io/<org>/charts
```

Install from OCI:

```bash
helm install myapp-release oci://ghcr.io/<org>/charts/myapp \
  --version 0.1.0 -n demo --create-namespace
```

Pull chart locally:

```bash
helm pull oci://ghcr.io/<org>/charts/myapp --version 0.1.0
```

Common OCI registries:

- GHCR (`ghcr.io`)
- Azure Container Registry (ACR)
- Amazon ECR
- Google Artifact Registry (GAR)
- Harbor

---

## 12) Versioning Best Practices

In `Chart.yaml`:

- `version`: chart package version (SemVer)
- `appVersion`: app/container version (string)

Rules:

- Bump `version` whenever chart templates/values change.
- Keep `appVersion` aligned with image tag when helpful.

---

## 13) CI/CD Flow (Typical)

1. `helm lint`
2. `helm template` (or `helm install --dry-run --debug`)
3. Package chart (`helm package`)
4. Publish to repo or OCI registry
5. Deploy with `helm upgrade --install`
6. Verify with `helm status` and `kubectl get`/`describe`

---

## 14) Debugging and Troubleshooting

Render with debug:

```bash
helm template myapp-release ./myapp --debug
```

Dry-run install/upgrade:

```bash
helm upgrade --install myapp-release ./myapp -n demo --dry-run --debug
```

Get manifest deployed by release:

```bash
helm get manifest myapp-release -n demo
```

Get values in use:

```bash
helm get values myapp-release -n demo
helm get values myapp-release -n demo --all
```

---

## 15) Recommended Project Layout for Real Teams

```text
helm/
  charts/
    myapp/
      Chart.yaml
      values.yaml
      values-dev.yaml
      values-prod.yaml
      templates/
  scripts/
    lint.sh
    package.sh
    publish.sh
```

If you manage many apps, keep one chart per app and separate env override files.

---

## 16) Security and Operational Tips

- Pin image tags (avoid `latest` in production).
- Keep secrets out of plain `values.yaml` (use external secret manager or encrypted files).
- Use chart provenance/signing when required.
- Validate RBAC and resource requests/limits in templates.
- Add health probes and HPA values where appropriate.

---

## 17) Quick Command Cheat Sheet

```bash
helm create <chart>
helm lint <chart-dir>
helm template <release> <chart-dir>
helm install <release> <chart-dir> -n <ns> --create-namespace
helm upgrade --install <release> <chart-dir> -n <ns>
helm uninstall <release> -n <ns>
helm repo add <name> <url>
helm repo update
helm search repo <keyword>
helm dependency update <chart-dir>
helm package <chart-dir>
helm registry login <registry>
helm push <chart.tgz> oci://<registry>/<path>
```

---

## 18) Practical Next Steps

- Create your own chart with `helm create`.
- Replace default templates with your app manifests.
- Add `values-dev.yaml` and `values-prod.yaml`.
- Configure one publishing path:
  - classic Helm repo, or
  - OCI registry (recommended).
- Automate lint/package/publish/deploy in CI.

---

If you want, I can also generate a ready-to-use example chart under this folder with:
- Deployment + Service + Ingress
- HPA values
- Separate dev/prod values files
- OCI publish script
