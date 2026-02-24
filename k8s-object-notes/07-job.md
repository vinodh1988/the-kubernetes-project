# Job

## What it is
`Job` runs one-off or batch tasks to completion.

## When to use
- Data migration
- Report generation
- Backup/restore tasks

## Key fields
- `spec.completions`: total successful Pods required
- `spec.parallelism`: concurrent Pods
- `spec.backoffLimit`: retry limit before failure
- `spec.ttlSecondsAfterFinished`: auto cleanup

## Common commands
```bash
kubectl get jobs
kubectl create job db-migrate --image=alpine -- sh -c "echo migrate; sleep 5"
kubectl logs job/db-migrate
kubectl describe job db-migrate
kubectl delete job db-migrate
```

## YAML example
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: db-migrate
spec:
  completions: 1
  parallelism: 1
  backoffLimit: 2
  ttlSecondsAfterFinished: 3600
  template:
    spec:
      restartPolicy: Never
      containers:
        - name: migrate
          image: busybox:1.36
          command: ["sh", "-c", "echo running migration; sleep 10; echo done"]
```

## Practical notes
- `restartPolicy` must be `OnFailure` or `Never`.
- Use `ttlSecondsAfterFinished` to reduce object clutter.
