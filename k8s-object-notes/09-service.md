# Service

## What it is
`Service` provides stable networking and load balancing to matching Pods.

## When to use
- Stable internal endpoint for changing Pods
- Expose workloads inside or outside cluster

## Service types
- `ClusterIP`: internal-only (default)
- `NodePort`: exposes on each node IP + port
- `LoadBalancer`: cloud LB integration
- `ExternalName`: DNS alias to external service

## Key fields
- `spec.selector`: targets Pod labels
- `spec.ports[]`: service and target ports
- `spec.type`: exposure model

## Common commands
```bash
kubectl get svc
kubectl expose deployment web --port=80 --target-port=80 --type=ClusterIP
kubectl describe svc web
kubectl get endpoints web
kubectl delete svc web
```

## YAML example
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web
spec:
  type: ClusterIP
  selector:
    app: web
  ports:
    - name: http
      port: 80
      targetPort: 80
```

## Practical notes
- Selectorless Service can be paired with manual Endpoints/EndpointSlices.
- `port` is client-facing, `targetPort` is Pod container port.
