# Create dir for all exec files
New-Item -Path 'c:\' -Name 'bin' -ItemType Directory -Force

############# add c:\bin to EnvironmentVariableus user
################################################################################################################################

$oldPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::User)
if ($oldPath.Split(';') -inotcontains 'C:\bin'){
  [Environment]::SetEnvironmentVariable('Path', $('{0};c:\bin' -f $oldPath), [EnvironmentVariableTarget]::User)
}

$UserPath = [Environment]::GetEnvironmentVariable('Path', 'User')
#$MachinePath = [Environment]::GetEnvironmentVariable('Path', 'Machine')

Write-Host "${UserPath}"

############# minikube
################################################################################################################################

$downloadUrlMinikube = "https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe"
$desctMinikube = "c:\bin\minikube.exe"

Write-Host "Downloading minikube"
Invoke-WebRequest $downloadUrlMinikube -OutFile $desctMinikube

Write-Host "minikube is now installed!"


############# Kubectl
################################################################################################################################
$downloadUrlKubectl = "https://dl.k8s.io/release/v1.28.3/bin/windows/amd64/kubectl.exe"
$desctKubectl = "c:\bin\kubectl.exe"

Write-Host "Downloading Kubectl"
Invoke-WebRequest $downloadUrlKubectl -OutFile $desctKubectl -UseBasicParsing

#Copy-Item $desctKubectl -Destination "c:\bin\k.exe"

Write-Host "Kubectl is now installed!"


# https://www.shellhacks.com/kubectl-autocomplete-in-powershell/

$DocumentsPath = [Environment]::GetFolderPath("MyDocuments")
$WindowsPowerShellPath = "$DocumentsPath\WindowsPowerShell"


if (Test-Path -Path $WindowsPowerShellPath) {
    Write-Host "Folder $WindowsPowerShellPath already exists."
} else {
    Write-Host "Folder $WindowsPowerShellPath does not exist, let's create it"
    New-item -Path $WindowsPowerShellPath -ItemType Directory
}

& $desctKubectl completion powershell >> $PROFILE
. $PROFILE
echo 'Set-Alias -Name k -Value kubectl' >> $PROFILE
echo 'Register-ArgumentCompleter -CommandName k -ScriptBlock $__kubectlCompleterBlock' >> $PROFILE
. $PROFILE

############# Helm
################################################################################################################################
$downloadUrlHelm = "https://get.helm.sh/helm-v3.14.0-windows-amd64.zip"
$desctHelm = "c:\bin\helm-v3.14.0-windows-amd64.zip"
$desctHelmTmp = "c:\bin\tmp"

Write-Host "Downloading Helm"
Invoke-WebRequest $downloadUrlHelm -OutFile $desctHelm -UseBasicParsing

Expand-Archive $desctHelm -DestinationPath $desctHelmTmp

Copy-Item "$desctHelmTmp\windows-amd64\helm.exe" -Destination "c:\bin\helm.exe"

Remove-Item -LiteralPath $desctHelmTmp -Force -Recurse
Remove-Item $desctHelm

Write-Host "Helm is now installed!"

############# Terraform
################################################################################################################################
$downloadUrlTerraform = "https://releases.hashicorp.com/terraform/1.7.1/terraform_1.7.1_windows_amd64.zip"
$desctTerraform = "c:\bin\terraform_1.7.1_windows_amd64.zip"

Write-Host "Downloading Terraform"
Invoke-WebRequest $downloadUrlTerraform -OutFile $desctTerraform -UseBasicParsing

Expand-Archive $desctTerraform -DestinationPath c:\bin

Remove-Item $desctTerraform

Write-Host "Terraform is now installed!"

############# Tofu
################################################################################################################################
$downloadUrlTofu= "https://github.com/opentofu/opentofu/releases/download/v1.6.1/tofu_1.6.1_windows_amd64.zip"
$desctTofu = "c:\bin\tofu_1.6.1_windows_amd64.zip"
$desctTofuTmp = "c:\bin\tmp"

Write-Host "Downloading Tofu"
Invoke-WebRequest $downloadUrlTofu -OutFile $desctTofu -UseBasicParsing

Expand-Archive $desctTofu -DestinationPath $desctTofuTmp

Copy-Item "$desctTofuTmp\tofu.exe" -Destination "c:\bin\tofu.exe"

Remove-Item -LiteralPath $desctTofuTmp -Force -Recurse
Remove-Item $desctTofu

Write-Host "Tofu is now installed!"


