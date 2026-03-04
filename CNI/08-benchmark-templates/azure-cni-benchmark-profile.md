# Azure CNI Benchmark Profile

## Scope focus

- Native VNet-routable pod networking behavior
- AKS subnet/IP planning efficiency
- Policy and observability integration in Azure ecosystem

## Configuration checklist

- AKS version:
- Azure CNI mode/version:
- Subnet CIDR and utilization:
- Node pool sizing:
- Network policy mode/add-ons:

## Must-run tests

1. Pod provisioning latency during burst scale
2. Cross-node service path latency and throughput
3. IP/subnet pressure test under HPA and rollouts
4. Policy validation with realistic app dependencies

## Key observations to capture

- Pod start delays due to subnet constraints
- Reliability under scale-up and scale-down churn
- Policy enforcement correctness and troubleshooting effort
- Alignment with Azure governance controls

## Verdict prompts

- Can address management support growth safely?
- Is native Azure integration reducing operational complexity?
- Are performance and security objectives both met?
