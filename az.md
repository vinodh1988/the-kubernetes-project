# Azure CLI installation on Red Hat 9

## Install Azure CLI (RHEL 9)

Run these commands on your Red Hat 9 host:

```bash
# 1) Import Microsoft GPG key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# 2) Add Microsoft package repository for RHEL 9
sudo dnf install -y https://packages.microsoft.com/config/rhel/9.0/packages-microsoft-prod.rpm

# 3) Install Azure CLI
sudo dnf install -y azure-cli
```

## Verify installation

```bash
az version
```

## First sign-in (optional)

```bash
az login
```

## Update later

```bash
az upgrade
# or
sudo dnf update azure-cli
```
