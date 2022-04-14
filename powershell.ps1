# Check Powershell version
$PSVersionTable

# Check if Powershell is 32-bit or 64-bit
[Environment]::Is64BitProcess

# Check module path
$env:PSModulePath -split (';')