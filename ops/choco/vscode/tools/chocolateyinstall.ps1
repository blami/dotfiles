$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://code.visualstudio.com/sha/download?build=stable&os=win32-x64'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Visual Studio Code*'

  silentArgs    = '/VERYSILENT /NORESTART /DIR="C:\Program Files\VSCode" /MERGETASKS=!runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
