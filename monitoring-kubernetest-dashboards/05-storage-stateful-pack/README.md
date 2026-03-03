# 05-storage-stateful-pack

## Purpose

Storage reliability and stateful workload dashboard pack.

## Must-have panels

- PVC usage % and free capacity trend
- PV provisioning failures and latency
- StatefulSet replica health
- Volume IOPS/throughput/latency
- Filesystem saturation risk by node/volume

## Best ready-made dashboard sources

- Grafana Community: search `Kubernetes persistent volume`, `PVC`, `StatefulSet`
- CSI/storage vendor dashboards (Azure Disk, EBS, GCE PD)

## Import notes

- Validate storage class labels in queries
- Add filters by `storageclass`, `namespace`, `statefulset`
- Include predictive trend panels for capacity exhaustion

## Alert links to include

- PVC > 80% capacity
- PV attach/mount failures
- StatefulSet unavailable replicas

## Success output

Prevents surprise storage outages in stateful services.
