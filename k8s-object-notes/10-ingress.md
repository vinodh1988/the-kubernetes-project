# Ingress

## What it is
`Ingress` defines HTTP/HTTPS routing rules to Services, managed by an Ingress Controller.

## When to use
- Host/path-based routing
- TLS termination at edge
- Consolidating external HTTP entry points

## Key fields
- `spec.ingressClassName`: controller class
- `spec.rules[]`: host + paths + backend services
- `spec.tls[]`: TLS secrets and hostnames

## Common commands
```bash
kubectl get ingress
kubectl describe ingress web-ing
kubectl apply -f ingress.yaml
kubectl delete ingress web-ing
```

## YAML example
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-ing
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - app.example.com
      secretName: app-example-tls
  rules:
    - host: app.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: web
                port:
                  number: 80
```

## Practical notes
- Ingress resource alone does nothing without a running controller.
- For advanced L4/L7, Gateway API is the newer extensible model.
