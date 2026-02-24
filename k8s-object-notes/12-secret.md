# Secret

## What it is
`Secret` stores sensitive data (credentials, keys, tokens) in Kubernetes.

## When to use
- DB passwords
- API tokens
- TLS certificates (`kubernetes.io/tls`)

## Key fields
- `type`: `Opaque`, `kubernetes.io/tls`, etc.
- `data`: base64-encoded values
- `stringData`: plaintext convenience (server encodes to `data`)

## Common commands
```bash
kubectl get secrets
kubectl create secret generic db-credentials --from-literal=username=app --from-literal=password='S3cure!'
kubectl create secret tls app-tls --cert=tls.crt --key=tls.key
kubectl describe secret db-credentials
kubectl delete secret db-credentials
```

## YAML example
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
type: Opaque
stringData:
  username: app
  password: S3cure!
```

## Practical notes
- Base64 is encoding, not encryption.
- Enable encryption at rest in cluster configuration.
- Restrict access with least-privilege RBAC.
