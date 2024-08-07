$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64         = $url64
  softwareName  = 'Mozilla Firefox*'

  silentArgs    = '/S /InstallDirectoryPath="C:\Program Files\Mozilla Firefox" /PreventRebootRequired /PrivateBrowsingShortcut=false /DesktopShortcut=false /TaskbarShortcut=true /MaintenanceService=true'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
