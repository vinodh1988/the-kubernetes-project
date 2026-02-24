# ConfigMap

## What it is
`ConfigMap` stores non-sensitive configuration as key-value pairs.

## When to use
- App configuration values
- Environment-specific settings
- Mounted config files for applications

## Key fields
- `data`: UTF-8 key-value entries
- `binaryData`: base64-encoded binary content

## Common commands
```bash
kubectl get configmap
kubectl create configmap app-config --from-literal=LOG_LEVEL=info --from-literal=APP_MODE=prod
kubectl create configmap app-file-config --from-file=app.properties
kubectl describe configmap app-config
kubectl delete configmap app-config
```

## YAML example
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  LOG_LEVEL: info
  APP_MODE: production
  app.properties: |
    cache.enabled=true
    cache.ttl.seconds=300
```

## Practical notes
- Inject via env vars or volume mounts.
- ConfigMap updates do not instantly reload app process unless app supports reload.
