# Check Powershell version
$PSVersionTable

# Check if Powershell is 32-bit or 64-bit
[Environment]::Is64BitProcess

# Check module path
$env:PSModulePath -split (';')

# Load Windows PowerShell modules into PowerShell v7 by invokng the -UseWindowsPowerShell switch parameter of the Import-Module command

#Region Windows Server
# Network
Set-NetAdapterBinding -Name * -ComponentID ms_tcpip6 -Enabled $false
Set-NetConnectionProfile -InterfaceAlias * -NetworkCategory Private # Or Domain or Public

# Setup Domain Controller
Get-WindowsFeature
Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools
# Install-Module ActiveDirectory (included in management tools)
Test-ADDSForestInstallation -DomainName "fnk.lab.local" -InstallDns
Install-ADDSForest -DomainName "fnk.lab.local" -InstallDNS

#endregion