# CronJob

## What it is
`CronJob` creates Jobs on a cron schedule.

## When to use
- Scheduled backups
- Recurring data sync or cleanup
- Periodic reports

## Key fields
- `spec.schedule`: cron expression
- `spec.concurrencyPolicy`: `Allow`, `Forbid`, `Replace`
- `spec.startingDeadlineSeconds`: missed window tolerance
- `spec.successfulJobsHistoryLimit` / `failedJobsHistoryLimit`

## Common commands
```bash
kubectl get cronjobs
kubectl create cronjob nightly-backup --image=busybox --schedule="0 2 * * *" -- sh -c "echo backup"
kubectl describe cronjob nightly-backup
kubectl get jobs --selector=job-name
kubectl delete cronjob nightly-backup
```

## YAML example
```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: nightly-backup
spec:
  schedule: "0 2 * * *"
  concurrencyPolicy: Forbid
  successfulJobsHistoryLimit: 3
  failedJobsHistoryLimit: 1
  jobTemplate:
    spec:
      template:
        spec:
          restartPolicy: OnFailure
          containers:
            - name: backup
              image: busybox:1.36
              command: ["sh", "-c", "echo backup start; sleep 5; echo backup done"]
```

## Practical notes
- Time zone behavior depends on cluster version/settings.
- Keep history limits small in high-frequency schedules.
