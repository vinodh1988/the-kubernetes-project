# 02 — CNI Plugin Deep Dive

## 1) Calico

### Architecture

- Data plane: iptables or eBPF mode
- Control components: Felix, Typha (for scale), optional BGP integration
- Policy-first design; strong NetworkPolicy ecosystem

### Strengths

- Mature, widely adopted
- Strong policy model and operational tooling
- Works in many environments (on-prem, cloud, hybrid)

### Considerations

- Advanced setups (BGP, large policy sets) require careful tuning
- eBPF mode requires validation with your kernel and platform baseline

## 2) Cilium

### Architecture

- eBPF-centric data plane
- Rich observability (Hubble)
- Can provide kube-proxy replacement functionality

### Strengths

- High-performance service routing and policy enforcement
- Deep visibility (flows, DNS, service interactions)
- Advanced policy capabilities, including L7 integrations

### Considerations

- Team needs comfort with eBPF-oriented operations
- Kernel and distro compatibility must be validated early

## 3) Flannel

### Architecture

- Lightweight networking (VXLAN/host-gw backends)
- Focused on pod connectivity, not advanced policy

### Strengths

- Very simple setup and low operational burden
- Good for learning labs and straightforward clusters

### Considerations

- Limited native policy and advanced security features
- Commonly paired with additional components for policy

## 4) Weave Net

### Architecture

- Overlay networking with integrated encryption options
- Historically popular for ease of setup

### Strengths

- Easy initial deployment
- Good abstraction for heterogeneous environments

### Considerations

- Less momentum in many modern enterprise stacks compared to Calico/Cilium

## 5) Antrea

### Architecture

- Built on Open vSwitch (OVS)
- Implements Kubernetes NetworkPolicy and Antrea-native policy CRDs

### Strengths

- Strong enterprise networking model
- Rich policy and traffic control options
- Works well where OVS expertise exists

### Considerations

- Operational model differs from iptables/eBPF-heavy ecosystems

## 6) Kube-Router

### Architecture

- Combines CNI, service proxying, and policy via BGP/iptables foundations

### Strengths

- Compact architecture for teams preferring integrated components

### Considerations

- Ecosystem and operational tooling are smaller than top-tier alternatives

## 7) AWS VPC CNI

### Architecture

- Pods receive VPC-routable IPs via ENIs
- Tight integration with AWS networking primitives

### Strengths

- Native AWS networking and security integration
- Reduced overlay complexity in EKS environments

### Considerations

- IP/subnet planning is critical
- Deeply AWS-specific (less portable)

## 8) Azure CNI

### Architecture

- Pods attached with VNet-routable addresses (mode-dependent)
- Native AKS integration and Azure policy/security tie-ins

### Strengths

- Strong Azure ecosystem integration
- Native routing and enterprise governance alignment

### Considerations

- Address planning and subnet sizing are major design constraints

## 9) OVN-Kubernetes

### Architecture

- OVN/OVS-based SDN model
- Often associated with OpenShift ecosystems

### Strengths

- Robust network virtualization model
- Good fit for OVN-aligned platform operations

### Considerations

- Requires familiarity with OVN operational workflows

## 10) How to short-list quickly

- Need strongest eBPF observability/perf: evaluate Cilium
- Need mature broad policy-first ecosystem: evaluate Calico
- Need simplest baseline networking: evaluate Flannel
- Need OVS enterprise features: evaluate Antrea or OVN-K
- Need native cloud networking first: evaluate AWS VPC CNI / Azure CNI
