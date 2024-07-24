$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Steam*'

  silentArgs    = '/S /D=C:\Games\Steam'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
