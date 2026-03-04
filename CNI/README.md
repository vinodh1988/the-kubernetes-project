# CNI (Container Network Interface) — Comprehensive Kubernetes Networking Guide

This project is a **deep, practical reference** for Kubernetes CNI networking and CNI plugin comparisons.

## Audience

- Platform engineers designing Kubernetes network architecture
- SRE/DevOps teams operating production clusters
- Security teams implementing segmentation and policy
- Developers who need to understand cluster networking behavior

## What you will learn

- Core CNI architecture and packet flow
- How major CNI plugins differ in design and capabilities
- Feature-by-feature comparison (performance, security, operations)
- When to choose each CNI for real-world scenarios
- Migration, troubleshooting, and day-2 operations

## Document map

- [01-cni-fundamentals/README.md](01-cni-fundamentals/README.md)
  - CNI spec, Kubernetes networking model, kube-proxy interactions, service routing
- [02-plugin-deep-dive/README.md](02-plugin-deep-dive/README.md)
  - Calico, Cilium, Flannel, Weave Net, Antrea, Kube-Router, AWS VPC CNI, Azure CNI, OVN-Kubernetes
- [03-comparisons/README.md](03-comparisons/README.md)
  - Side-by-side comparison matrix and scenario guidance
- [04-security/README.md](04-security/README.md)
  - NetworkPolicy, encryption, eBPF policy, multi-tenant isolation, compliance patterns
- [05-operations/README.md](05-operations/README.md)
  - Installation models, upgrades, observability, SLOs, troubleshooting runbook
- [06-migration-and-selection/README.md](06-migration-and-selection/README.md)
  - Selection framework, weighted scoring, migration strategy, risk management
- [07-hands-on-labs/README.md](07-hands-on-labs/README.md)
  - Practical labs and validation commands
- [08-benchmark-templates/README.md](08-benchmark-templates/README.md)
  - Vendor-specific benchmark profiles and a reusable benchmark plan template
- [09-scoring-sheet/README.md](09-scoring-sheet/README.md)
  - Weighted decision worksheet in Markdown and CSV formats
- [10-sample-decision/README.md](10-sample-decision/README.md)
  - Filled comparison example (Cilium vs Calico vs AWS VPC CNI)

## Quick comparison snapshot

| CNI | Best For | Data Plane | NetworkPolicy | Encryption | Scale Profile | Complexity |
|---|---|---|---|---|---|---|
| Cilium | High-performance policy + observability | eBPF | Advanced L3-L7 | WireGuard/IPsec | Very high | Medium-High |
| Calico | Flexible policy + broad ecosystem | iptables/eBPF | Advanced L3-L4 (+enterprise L7) | WireGuard/IPsec | High | Medium |
| Flannel | Simplicity | VXLAN/host-gw | No native (pair with Calico policy mode) | No native | Medium | Low |
| Antrea | Enterprise-friendly, OVS-centric | OVS + OpenFlow | Rich policy + cluster policies | IPsec/WireGuard (feature-dependent) | High | Medium |
| AWS VPC CNI | Native AWS networking | ENI/VPC routing | Via NetworkPolicy add-ons | VPC-level controls | High on AWS | Medium |
| Azure CNI | Native Azure networking | VNet/IP routing | Azure NP/Calico modes | Azure-native controls | High on Azure | Medium |
| OVN-Kubernetes | OpenShift and OVN ecosystems | OVS/OVN | Strong built-in policy | IPsec options by platform | High | Medium-High |

> Note: Exact capabilities vary by plugin version and Kubernetes distribution. Validate against current release notes before production rollout.

## Fast start checklist

1. Define non-functional requirements (latency, throughput, policy depth, multi-cluster, compliance).
2. Prioritize cloud constraints (native IPAM, subnet limits, route table limits).
3. Run a lab benchmark with your workload profile (not synthetic only).
4. Validate policy scale and troubleshooting ergonomics.
5. Plan upgrade and rollback strategy before production cutover.

## Suggested reading order

1. Fundamentals
2. Plugin deep dive
3. Comparisons
4. Security and operations
5. Selection and migration
6. Hands-on labs

## Related standards and references

- CNI specification and plugins (containernetworking)
- Kubernetes networking model
- NetworkPolicy API and implementation docs for your chosen CNI
