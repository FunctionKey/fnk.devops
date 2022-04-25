#Region PowerShell Environment
# Check Powershell version
$PSVersionTable
# Check if Powershell is 32-bit or 64-bit
[Environment]::Is64BitProcess
# Check module path
$env:PSModulePath -split (';')
# Load Windows PowerShell modules into PowerShell v7 by invokng the -UseWindowsPowerShell switch parameter of the Import-Module command
#endregion

#Region Network
# Configure IP Address
Get-NetIPAddress
New-NetIPAddress -IPAddress 10.0.0.4 -InterfaceIndex [Unit[int]] -DefaultGateway 10.0.0.1 -PrefixLength 24
#endregion

#Region Windows Remote Management
# Check TrustedHosts list
Get-Item WSMan:\localhost\Client\TrustedHosts
# Check host WinRM configuration
winrm get winrm/config
# Add specific computers to the TrustedHosts list
Set-Item WSMan:\localhost\Client\TrustedHosts -Value <ComputerName>,[<ComputerName>]    # Add more than one based on their hostname by separating them with a comma (,)
# Add computers to TrustedHosts list using the IP address
Set-Item WSMan:\localhost\Client\TrustedHosts -Value 10.10.10.1,[0:0:0:0:0:0:0:0]
# Add all computers to TrustedHosts list
Set-Item WSMan:\localhost\Client\TrustedHosts -Value *
# Add all domain computers to TrustedHosts list
Set-Item WSMan:\localhost\Client\TrustedHosts *.yourdomain.com
#endregion

#Region Windows Server
# Network
Set-NetAdapterBinding -Name * -ComponentID ms_tcpip6 -Enabled $false
Set-NetConnectionProfile -InterfaceAlias * -NetworkCategory Private # Or Domain or Public

# Setup Domain Controller
if (-not (Get-WindowsFeature "AD-Domain-Services").Installed) {
    try {
        Install-WindowsFeature -name "AD-Domain-Services" -IncludeManagementTools
        # Install-Module ActiveDirectory (included in management tools)
    }
    catch {
        Write-Error $_
    }
}
if (Test-ADDSForestInstallation -DomainName "fnk.lab.local" -InstallDns) {
    try {
        Install-ADDSForest -DomainName "fnk.lab.local" -InstallDNS
    }
    catch {
        Write-Error $_
    }
}
#endregion

#Region Active Directory
# Create a new AD User
New-ADUser `
    -Name "Kevin Sapp" `
    -GivenName "Kevin" `
    -Surname "Sapp" `
    -SamAccountName "kesapp-test" `
    -AccountPassword (Read-Host -AsSecureString "Input User Password") `
    -ChangePasswordAtLogon $True `
    -Company "Code Duet" `
    -Title "CEO" `
    -State "California" `
    -City "San Francisco" `
    -Description "Test Account Creation" `
    -EmployeeNumber "45" `
    -Department "Engineering" `
    -DisplayName "Kevin Sapp (Test)" `
    -Country "us" `
    -PostalCode "940001" `
    -Enabled $True

# Copy an existing account
$template_account = Get-ADUser -Identity kesapp-test -Properties State,Department,Country,-City # Not all properties can be copied over to other users. wildcard won't work here
$template_account.UserPrincipalName = $null # UPN must be unique accorss the AD Forest
New-ADUser `
    -Instance $template_account `
    -Name 'James Brown' `
    -SamAccountName 'jbrown' `
    -AccountPassword (Read-Host -AsSecureString "Input User Password") `
    -Enabled $True

# Manage AD Account
Set-ADAccountPassword -Identity (Read-Host "Username") -NewPassword (read-host "Pass" -AsSecureString)
Unlock-ADAccount -Identity (Read-Host "Username")
Set-ADUser -Identity "user.name" -SamAccountName "new.user.name"    # User logon name (pre-Windows 2000)
Set-ADUser -Identity "user.name" -UserPrincipalName "new.user.name@domain.local"    # User logon name
#endregion

#Region DHCP Server    # https://docs.microsoft.com/en-us/powershell/module/dhcpserver/?view=windowsserver2022-ps
# Check current DHCP configuration
Get-DhcpServerv4Scope
# Change DHCP Scope
Set-DhcpServerv4Scope -ScopeId 10.10.1.0 -StartRange 10.10.1.100 -EndRange 10.10.1.220
#endregion

#Region Desired State Configuration (DSC)
# Get ready
Get-Command -Noun dsc*
Get-DscResource
# Check how to configure each resource
Get-DscResource "File" | Select-Object -ExpandProperty Properties

# Step 1
# Generate a LCM (Local Configuration Manager) configuration for the target node(s)
# Target node LCM configuration
Configuration LCMConfig {
    # Parameters
    # Accepts a string value computername or defaults to localhost
    Param ([string[]]$ComputerName = "localhost")
        # Target node(s)
        Node $ComputerName {
            #LCM Resource
            LocalConfigurationManager {
                ConfigurationMode = "ApplyAndAutoCorrect"
                ConfigurationModeFrequencyMins = 30
            }
        }
}

# Generate MOF file
LCMConfig -ComputerName LocalDC01
# Check LCM Settings on target node
Get-DSCLocalConfigurationManager -CimSession LocalDC01
# Apply the LCMConfig for each targer node
Set-DscLocalConfigurationManager -Path LCMConfig
# Check the LCM Configuration again
Get-DscLocalConfigurationManager -CimSession LocalDC01
# Test if configuration is applied (detect drift)
Test-DscConfiguration -CimSession LocalDC01
#endregion