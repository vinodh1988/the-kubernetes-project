# Pod Update Strategy Notes

## RollingUpdate
- Default Deployment strategy in Kubernetes.
- Replaces Pods gradually.
- Use when zero/low downtime is needed.
- Key knobs: `maxSurge`, `maxUnavailable`.

## Recreate
- Terminates all old Pods before creating new Pods.
- Causes a short downtime window.
- Useful for apps that cannot run old/new versions together.

## Blue/Green
- Two full environments: Blue (current), Green (new).
- Traffic switches by Service selector change.
- Fast rollback by switching selector back.
- Needs extra capacity while both versions exist.

## Canary
- Send a small portion of traffic to new version first.
- In this project, traffic share is approximated by replica ratio.
- Observe behavior, then promote gradually or rollback quickly.
- For precise traffic percentages, use ingress/service mesh controls.
