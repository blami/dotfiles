$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/KiCad/kicad-source-mirror/releases/download/7.0.5/kicad-7.0.5-x86_64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'KiCad*'
  silentArgs    = '/S /D=C:\Program Files\KiCad'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
