<#
.SYNOPSIS
  Update all packages to the latest version using Chocolatey-AU
#>

$ErrorActionPreference = 'Stop' # stop on all errors

Get-ChildItem -Path $PSScriptRoot -Directory | ForEach-Object {
    $updatePs1 = (Join-Path -Path $_.FullName -ChildPath update.ps1)
    if (Test-Path -Path $updatePs1 -Type Leaf) {
        # Run update.ps1
        Push-Location $_.FullName
        & $updatePs1
        Pop-Location
    }
}
