# Multi Node Cluster (Red Hat + Flannel)

This project provides step-by-step instructions to create a Kubernetes multi-node cluster on Red Hat using the **Flannel** CNI network plugin.

> Note: You wrote “flanner”; the correct plugin name is **Flannel**.

## Target Setup

- 1 control-plane node (`cp-1`)
- 2+ worker nodes (`worker-1`, `worker-2`, ...)
- Red Hat Enterprise Linux 8/9 (or compatible)
- Kubernetes with `kubeadm`
- Pod CIDR: `10.244.0.0/16` (recommended for Flannel)

## 1) Prepare all nodes (control-plane + workers)

Run on **every node** as `root` (or with `sudo`):

```bash
# Set hostnames (example, set appropriately per node)
hostnamectl set-hostname cp-1

# Disable swap (required by kubelet)
swapoff -a
sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab

# Kernel modules and sysctl for Kubernetes networking
cat <<EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
modprobe overlay
modprobe br_netfilter

cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sysctl --system

# Optional but common in labs: disable SELinux enforcement
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# Open firewall ports (control-plane node will need more; these are baseline)
firewall-cmd --permanent --add-port=10250/tcp
firewall-cmd --reload
```

## 2) Install container runtime (containerd) on all nodes

```bash
dnf install -y containerd
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml >/dev/null

# Use systemd cgroup driver (recommended for kubelet)
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

systemctl enable --now containerd
```

## 3) Install Kubernetes packages on all nodes

```bash
cat <<EOF | tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
EOF

# Exclude kube packages from accidental upgrades is optional; shown here as standard
dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable --now kubelet
```

## 4) Initialize the control-plane node

Run **only on `cp-1`**:

```bash
# Replace with control-plane node IP
kubeadm init \
  --apiserver-advertise-address=<CONTROL_PLANE_IP> \
  --pod-network-cidr=10.244.0.0/16
```

Configure `kubectl` for your admin user:

```bash
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
```

Save the `kubeadm join ...` command printed by `kubeadm init`.

## 5) Install Flannel CNI (control-plane node)

```bash
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```

Verify:

```bash
kubectl get pods -n kube-flannel
kubectl get nodes
```

## 6) Join worker nodes to the cluster

Run on **each worker** using the join command from step 4:

```bash
kubeadm join <CONTROL_PLANE_IP>:6443 --token <TOKEN> \
  --discovery-token-ca-cert-hash sha256:<HASH>
```

If you lost the join command, regenerate on control-plane:

```bash
kubeadm token create --print-join-command
```

## 7) Verify multi-node cluster

Run on control-plane:

```bash
kubectl get nodes -o wide
kubectl get pods -A
```

Expected:
- All nodes should be `Ready`
- Flannel pods should be `Running`

## 8) Test cross-node networking

Deploy a quick test workload:

```bash
kubectl create deployment nginx --image=nginx --replicas=3
kubectl expose deployment nginx --port=80 --type=ClusterIP
kubectl get pods -o wide
kubectl get svc nginx
```

Optional connectivity test:

```bash
kubectl run -it --rm netshoot --image=nicolaka/netshoot -- /bin/bash
# inside pod:
curl nginx
exit
```

## Troubleshooting

- `NotReady` nodes after join:
  - Check kubelet: `systemctl status kubelet`
  - Check containerd: `systemctl status containerd`
- Flannel pods not running:
  - `kubectl -n kube-flannel get pods`
  - Ensure `--pod-network-cidr=10.244.0.0/16` was used in `kubeadm init`
- API server unreachable from workers:
  - Verify firewall rules and control-plane IP reachability

## Cleanup (optional)

On worker nodes:

```bash
kubeadm reset -f
```

On control-plane node:

```bash
kubeadm reset -f
rm -rf $HOME/.kube
```
