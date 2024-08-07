$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64         = $url64
  softwareName  = 'Steam*'

  silentArgs    = '/S /D=C:\Games\Steam'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
