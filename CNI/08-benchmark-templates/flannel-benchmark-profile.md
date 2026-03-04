# Flannel Benchmark Profile

## Scope focus

- Baseline pod networking performance
- Simplicity and low-overhead operations
- Overlay behavior and MTU impact

## Configuration checklist

- Flannel version:
- Backend (vxlan/host-gw):
- MTU value:
- Additional policy engine present (yes/no):

## Must-run tests

1. Same-node and cross-node pod connectivity throughput
2. Service path latency baseline
3. MTU stress test (large packet behavior)
4. Scale test for pod churn and restart recovery

## Key observations to capture

- Overlay overhead impact on throughput and latency
- Stability during high pod churn
- Limits due to missing native advanced policy
- Total operational simplicity score

## Verdict prompts

- Is simple connectivity sufficient for workload security needs?
- Do we need additional policy tooling that increases complexity?
- Is performance acceptable for production traffic profile?
