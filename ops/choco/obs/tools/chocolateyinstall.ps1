$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://cdn-fastly.obsproject.com/downloads/OBS-Studio-30.1.2-Full-Installer-x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64         = $url64
  softwareName  = 'OBS Studio*'

  silentArgs    = '/S /D=C:\Program Files\OBS'

  validExitCodes= @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
# TODO: Install plugins
