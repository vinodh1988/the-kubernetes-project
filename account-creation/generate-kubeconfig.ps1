param(
  [string]$Namespace = "account-creation",
  [string]$ServiceAccount = "account-creation-user",
  [string]$OutputFile = "account-creation-user.kubeconfig"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not (Get-Command kubectl -ErrorAction SilentlyContinue)) {
  Write-Error "kubectl is not installed or not in PATH."
  exit 1
}

& kubectl get namespace $Namespace *> $null
if ($LASTEXITCODE -ne 0) {
  Write-Error "Namespace '$Namespace' not found."
  exit 1
}

& kubectl -n $Namespace get serviceaccount $ServiceAccount *> $null
if ($LASTEXITCODE -ne 0) {
  Write-Error "ServiceAccount '$ServiceAccount' not found in namespace '$Namespace'."
  exit 1
}

$CurrentContext = (& kubectl config current-context 2>$null).Trim()
if ([string]::IsNullOrWhiteSpace($CurrentContext)) {
  Write-Error "No current kubectl context found."
  exit 1
}

Write-Host "Using context: $CurrentContext"
Write-Host "Generating kubeconfig: $OutputFile"

$KubeConfigContent = & kubectl config view --raw --minify --flatten
if ($LASTEXITCODE -ne 0) {
  Write-Error "Failed to read current kubeconfig context."
  exit 1
}

Set-Content -Path $OutputFile -Value $KubeConfigContent -Encoding ascii

$Token = (& kubectl -n $Namespace create token $ServiceAccount).Trim()
if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($Token)) {
  Write-Error "Failed to create token for ServiceAccount '$ServiceAccount'."
  exit 1
}

& kubectl --kubeconfig=$OutputFile config set-credentials $ServiceAccount --token=$Token *> $null
if ($LASTEXITCODE -ne 0) {
  Write-Error "Failed to set credentials in '$OutputFile'."
  exit 1
}

& kubectl --kubeconfig=$OutputFile config set-context --current --user=$ServiceAccount --namespace=$Namespace *> $null
if ($LASTEXITCODE -ne 0) {
  Write-Error "Failed to set context in '$OutputFile'."
  exit 1
}

if ($env:OS -eq "Windows_NT") {
  # Best-effort: restrict file ACL to current user on Windows.
  & icacls $OutputFile /inheritance:r /grant:r "$env:USERNAME:(R,W)" *> $null
}

Write-Host "Done. Kubeconfig generated: $OutputFile"
Write-Host "Validation commands:"
Write-Host "  kubectl --kubeconfig=$OutputFile get pods -A"
Write-Host "  kubectl --kubeconfig=$OutputFile auth can-i create deployment -n default"
Write-Host "  kubectl --kubeconfig=$OutputFile auth can-i create deployment -n $Namespace"
