$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.7-zip.org/a/7z2201-x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = '7-zip*'

  silentArgs    = '/S'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
