<#
.SYNOPSIS
  Update all packages to the latest version using Chocolatey-AU
#>
Import-Module Chocolatey-AU

$ErrorActionPreference = 'Stop' # stop on all errors
$au_root = "\\wsl.localhost\debian\home\blami\ops\choco" ; Update-AUPackages
