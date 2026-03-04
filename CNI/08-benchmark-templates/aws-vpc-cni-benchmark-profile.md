# AWS VPC CNI Benchmark Profile

## Scope focus

- Native VPC-routable pod networking behavior
- ENI/IP allocation efficiency
- EKS-integrated operability

## Configuration checklist

- EKS version:
- AWS VPC CNI version:
- Prefix delegation enabled:
- Instance type and ENI limits:
- Subnet CIDR and IP utilization:

## Must-run tests

1. Pod startup and IP allocation latency under burst scheduling
2. Throughput/latency across AZ and node boundaries
3. Scale test near ENI/IP limits
4. NetworkPolicy add-on overhead (if enabled)

## Key observations to capture

- Pod launch delay due to IP allocation pressure
- Error events near subnet exhaustion
- Steady-state latency compared to overlay alternatives
- Operational behavior during autoscaling spikes

## Verdict prompts

- Does subnet/IP model support 12-18 month growth?
- Are ENI/IP limits a blocker for density targets?
- Is AWS-native integration the strongest fit for platform goals?
