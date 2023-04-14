$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/ShareX/ShareX/releases/download/v15.0.0/ShareX-15.0.0-setup.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'ShareX*'

  silentArgs    = '/VERYSILENT'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
