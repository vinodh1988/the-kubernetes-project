# Adhoc Commands

## 2026-02-23

### Curl pod IP from inside pod (`api-pod`)

```bash
# Run curl from inside the pod (if curl exists in the image)
kubectl exec -it api-pod -- curl -v http://10.244.0.5

# Quick status-only check
kubectl exec -it api-pod -- sh -c "curl -s -o /dev/null -w '%{http_code}\n' http://10.244.0.5"
```

### If `curl` is not installed in the pod

```bash
# Try wget if available
kubectl exec -it api-pod -- wget -qO- http://10.244.0.5

# Or launch a temporary curl pod in same namespace and test
kubectl run curl-test --rm -it --restart=Never --image=curlimages/curl -- curl -v http://10.244.0.5
```
