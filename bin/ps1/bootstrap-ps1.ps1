# Setup Powershell redirection to $env:USERPROFILE\.profile.ps1
$ErrorActionPreference = "stop"

$profileContent = @"
# This file is auto-generated. Make changes in USERPROFILE\.profile.ps1
. $(Join-Path $env:USERPROFILE ".profile.ps1")
"@

# Find profile.ps1 path and make it absolute
$profilePath = $($profile | Select -ExpandProperty CurrentUserAllHosts)
if (-not [System.IO.Path]::IsPathRooted($profilePath)) {
    $profilePath = Join-Path -Path $env:USERPROFILE -ChildPath $profilePath
}

# Overwrite profile.ps1 file with redirection file
New-Item -Force -Path $profilePath
Set-Content -Force -Path $profilePath -Value $profileContent

# Hide the profile.ps1 directory
$profileDir = Get-Item -Force $(Split-Path -Path $profilePath -Parent)
$profileDir.attributes += "Hidden"
