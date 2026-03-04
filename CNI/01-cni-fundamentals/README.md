# 01 — CNI Fundamentals

## 1) What CNI is

CNI (Container Network Interface) is a specification and plugin model that configures networking for Linux containers. In Kubernetes, CNI plugins are invoked by the container runtime (through CRI integration) to:

- Attach pod network interfaces
- Assign pod IP addresses
- Configure routes and rules
- Enforce network connectivity rules (depending on plugin capability)

CNI itself is a **plugin contract**, not a single implementation.

## 2) Kubernetes networking model basics

Kubernetes networking expects:

- Every pod gets an IP
- Pods can communicate with each other without NAT (in the base model)
- Nodes can communicate with all pods
- Services provide stable virtual IPs (ClusterIP) and load balancing

To satisfy this, clusters use:

- **Pod networking**: CNI-created virtual interfaces and overlay/underlay routing
- **Service networking**: kube-proxy (iptables/IPVS) or eBPF replacements
- **Policy layer**: NetworkPolicy enforced by CNI implementation

## 3) CNI execution flow (simplified)

1. Scheduler places pod on a node.
2. Kubelet asks runtime to create sandbox.
3. Runtime invokes CNI `ADD` with pod metadata.
4. CNI plugin creates veth pair, sets namespace interface, assigns IP.
5. CNI configures routes/tunnels/encapsulation as needed.
6. On pod deletion, runtime invokes CNI `DEL` for cleanup.

## 4) Data planes and packet path options

### Overlay mode

- Uses encapsulation (e.g., VXLAN)
- Easier setup across L3 boundaries
- Adds header overhead

### Underlay/native routing mode

- Uses cloud VPC/VNet or routed fabric directly
- Better performance and lower overhead
- Requires route/IPAM design maturity

### eBPF-based path

- Moves packet processing into kernel eBPF programs
- Enables faster service load balancing and advanced observability
- Operationally powerful but requires kernel feature compatibility

## 5) kube-proxy interaction models

- **Traditional:** CNI + kube-proxy (iptables/IPVS)
- **eBPF service replacement:** Some CNIs (for example Cilium) can replace/augment kube-proxy behavior

Implications:

- Different latency and CPU profiles
- Different debugging tools (`iptables` vs eBPF maps/tools)

## 6) NetworkPolicy fundamentals

NetworkPolicy is an allow-list model at L3/L4 in core Kubernetes APIs:

- If no policy selects a pod, traffic is allowed by default.
- Once policies select a pod for ingress/egress, traffic is denied unless explicitly allowed.
- Policy behavior depends on plugin implementation fidelity.

## 7) IP Address Management (IPAM)

Common approaches:

- Node-local block allocation
- Cloud-native IPAM (ENI/VNet-backed)
- Centralized controllers

What matters:

- Pod density per node
- Subnet exhaustion risk
- Route scale limits
- Address reuse and cleanup reliability

## 8) Common CNI architectural trade-offs

- Simplicity vs feature depth
- Overlay convenience vs underlay performance
- iptables familiarity vs eBPF performance/complexity
- Native cloud integration vs multi-cloud portability

## 9) Production readiness checklist

- Capacity model: max pods/node and max nodes/cluster
- Policy model: namespace isolation and least privilege
- Observability: flow logs, drop reasons, DNS and service visibility
- Upgrade path: rolling and rollback tested
- Security controls: encryption in transit where required
