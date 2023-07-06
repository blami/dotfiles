$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/dorssel/usbipd-win/releases/download/v3.0.0/usbipd-win_3.0.0.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  softwareName  = 'usbipd-win*'
  silentArgs    = '/qn /norestart'
  validExitCodes= @(0, 1641, 2010)
}

Install-ChocolateyPackage @packageArgs
