# 04-networking-ingress-pack

## Purpose

Network and ingress dashboard pack to track traffic health, errors, and latency.

## Must-have panels

- Ingress request rate by host/path
- 4xx/5xx split by ingress/service
- Upstream latency percentiles
- DNS error/latency indicators
- Service-to-service network error rates

## Best ready-made dashboard sources

- NGINX Ingress Grafana dashboards (community + official examples)
- Service mesh dashboards (if Istio/Linkerd used)

## Import notes

- Confirm ingress metrics endpoint enabled
- Normalize labels for `ingress`, `service`, `namespace`
- Add TLS cert expiry panel if available

## Alert links to include

- 5xx spike on ingress
- Upstream latency above SLO
- DNS resolution failures

## Success output

Great for rapid detection of user-facing traffic problems.
