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


#endregion