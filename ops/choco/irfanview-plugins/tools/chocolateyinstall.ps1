$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.irfanview.info/files/iview462_plugins_x64_setup.exe'
$checksum   = '29542a9229a36e4e7be5a9b2a3a433632ddc06e40fe2324ad7317b0679b389dc'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  softwareName  = 'Irfan View Plugins*'

  silentArgs    = '/silent /folder="C:\Program Files\IrfanView"'

  # For download, Referer: HTTP header must be set
  options       = @{Headers = @{Referer = "https://www.irfanview.info/"}}

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
