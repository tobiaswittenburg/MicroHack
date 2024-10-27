# Oracle Microhack Test environment

## Deploy the environment

~~~pwsh
az login
$prefix="cptdazoracle"
$location="germanywestcentral"
$vmAdminUsername="chpinoto"
# move into the corresponding directory if not already there
cd .\03-Azure\01-03-Infrastructure\10_Oracle_on_Azure\resources\http.server\azure\

# Create SSH key pair
mkdir .\.ssh
$sshKeyPath="./.ssh/${prefix}_id_rsa"
ssh-keygen -m PEM -t RSA -C "chpinoto@$prefix RSA" -f $sshKeyPath -N "demo!pass123"
# Output the public key path
$publicKeyPath="${sshKeyPath}.pub"
# Read the content of the public key file into a variable
$publicKeyContent = Get-Content -Path $publicKeyPath

# Retrieve public IP address using ipinfo.io
$publicIp = Invoke-RestMethod -Uri "https://ipinfo.io/ip"

# Make the variables available to the Terraform deployment via env.
$env:TF_VAR_prefix=$prefix
$env:TF_VAR_location=$location
$env:TF_VAR_ssh_vm_public_key=$publicKeyContent
$env:TF_VAR_my_ip=$publicIp
$env:TF_VAR_vm_admin_username=$vmAdminUsername
# show current state of my terraform deployment
terraform show
terraform init
terraform fmt
terraform validate
terraform plan -out tfplan1
terraform show
terraform show tfplan1
terraform apply --auto-approve tfplan1
terraform show
~~~

## Remote Connect with SSH

~~~pwsh
# Append new SSH connection to the .ssh config file
$currentPath = Get-Location
$sshPrivateKeyPath = "$currentPath\.ssh\${prefix}_id_rsa"
$nodejsVmFqdn = az network public-ip show -g $prefix -n ${prefix}nodejs --query "dnsSettings.fqdn" --output tsv
nslookup $nodejsVmFqdn # will return the IP address if set to static in azure
# Create the SSH config entry
$sshConfigEntry = @"
Host ${prefix}nodejs
    HostName $nodejsVmFqdn
    User $vmAdminUsername
    IdentityFile $sshPrivateKeyPath
"@

# Append the entry to the SSH config file
$sshConfigPath = Join-Path -Path $env:USERPROFILE -ChildPath ".ssh\config"
Add-Content -Path $sshConfigPath -Value $sshConfigEntry
# SSH into the remote VM
ssh chpinoto@$nodejsVmFqdn -i $sshPrivateKeyPath -vvv

# Open the remote SSH connection in VS Code
# based on https://code.visualstudio.com/docs/remote/troubleshooting#_connect-to-a-remote-host-from-the-terminal
code --remote ssh-remote+${prefix}nodejs
~~~

## Misc

### How to shorten the powershell terminal path

~~~pwsh
notepad $PROFILE
~~~

Add the followinfg line to the notepad and save it.

~~~pwsh
function prompt {
    $currentPath = (Get-Location).Path
    $shortPath = Split-Path -Leaf $currentPath
    "$shortPath> "
}
# shortcut for terraform
Set-Alias -Name tf -Value terraform
~~~

Then run the following command to reload the profile.

~~~pwsh
. $PROFILE
~~~
