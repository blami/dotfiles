$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/win64/nasm-2.16.01-win64.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  fileFullPath  = $(Join-Path $toolsDir 'nasm.zip')
  destination   = "C:\Devel\nasm"
}

Get-ChocolateyWebFile @packageArgs
Get-ChocolateyUnzip @packageArgs

# Move contents of nasm/nasm-<VERSION> to C:\Devel\nasm
$subDir = $(Join-Path $packageArgs.destination "$($env:ChocolateyPackageName)-$($env:ChocolateyPackageVersion)")
Get-ChildItem -Path "$subDir/*" -Force | Move-Item -Destination $packageArgs.destination -Force

Install-ChocolateyPath -PathToInstall $packageArgs.destination -PathType User

# Remove downloaded files and sub-directory
Remove-Item $packageArgs.fileFullPath
Remove-Item $subDir
