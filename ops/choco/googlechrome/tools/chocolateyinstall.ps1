$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  softwareName  = 'Google Chrome*'

  silentArgs    = '/quiet /norestart'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
