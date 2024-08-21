$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = "https://www.axialis.com/downloads/IconWorkshop-Pro.exe"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64         = $url64
  softwareName  = 'Axialis IconWorkshop*'

  silentArgs    = '/q /n /f "C:\Program Files\IconWorkshop"'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
