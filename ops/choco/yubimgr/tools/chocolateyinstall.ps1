$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://developers.yubico.com/yubikey-manager-qt/Releases/yubikey-manager-qt-latest-win64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'YubiKey Manager*'

  silentArgs    = '/S'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
