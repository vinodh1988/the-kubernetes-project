# 03 — CNI Comparison Matrix

## 1) Feature matrix

| Capability | Cilium | Calico | Flannel | Antrea | AWS VPC CNI | Azure CNI | OVN-Kubernetes |
|---|---|---|---|---|---|---|---|
| Primary data plane | eBPF | iptables/eBPF | VXLAN/host-gw | OVS/OpenFlow | VPC routing | VNet routing | OVN/OVS |
| Kubernetes NetworkPolicy | Yes | Yes | No (native) | Yes | Add-on dependent | Mode dependent | Yes |
| Advanced policy (L7/microseg) | Strong | Strong (varies by edition/mode) | Limited | Strong | Limited-native | Limited-native | Moderate-Strong |
| Encryption in transit | WireGuard/IPsec | WireGuard/IPsec | Limited-native | Available by feature set | Cloud-level + add-ons | Cloud-level + add-ons | Platform dependent |
| Observability depth | Very high | High | Basic | Moderate-High | AWS tools + plugin metrics | Azure tools + plugin metrics | Moderate |
| Multi-cloud portability | High | High | High | High | Low | Low | Medium |
| Operational complexity | Medium-High | Medium | Low | Medium | Medium | Medium | Medium-High |

## 2) Performance considerations

### Throughput and latency

- Native routing and eBPF paths usually reduce overhead compared to pure overlays.
- Overlay encapsulation adds bytes and CPU cost, especially at high throughput.

### CPU efficiency

- eBPF service handling can reduce iptables rule traversal overhead.
- Large policy sets in iptables mode can increase packet processing cost.

### Scale characteristics

- Route table growth, policy cardinality, and endpoint churn define practical limits.
- “Max scale” claims only matter when matched to your workload pattern.

## 3) Operational comparison

| Dimension | Cilium | Calico | Flannel | Antrea |
|---|---|---|---|---|
| Day-0 install simplicity | Medium | Medium | High | Medium |
| Day-2 troubleshooting ergonomics | High with Hubble tooling | High with mature docs/tooling | Medium | Medium |
| Upgrade complexity | Medium | Medium | Low-Medium | Medium |
| Policy authoring experience | Advanced | Advanced | Minimal | Advanced |

## 4) Security comparison

- **Baseline isolation:** Calico, Cilium, Antrea, OVN-K generally offer strong policy enforcement.
- **Deep visibility + identity:** Cilium stands out for eBPF visibility and flow context.
- **Cloud-native governance:** AWS/Azure CNIs align well with platform security controls but may need add-ons for advanced Kubernetes-native microsegmentation.

## 5) Decision heuristics

Choose **Cilium** when:

- You need advanced visibility and eBPF-based performance
- You can support kernel compatibility and eBPF operational maturity

Choose **Calico** when:

- You need broad compatibility and mature policy operations
- You want flexibility between traditional and modern data plane modes

Choose **Flannel** when:

- You want very simple pod networking with minimal operational overhead
- Advanced policy is not a primary requirement

Choose **cloud-native CNI (AWS/Azure)** when:

- You optimize for provider-native networking and governance integration
- Multi-cloud portability is not a top requirement

## 6) Comparison pitfalls to avoid

- Benchmarking only idle or synthetic traffic
- Ignoring DNS path and service mesh interactions
- Underestimating troubleshooting complexity as cluster scales
- Selecting based on popularity rather than workload fit
