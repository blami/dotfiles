$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://sourceforge.net/projects/winscp/files/WinSCP/5.21.8/WinSCP-5.21.8-Setup.exe/download'
$checksum   = 'abf0bb2c73dea0b66de3f2fa34c03987980c3db4406f07c5f3b8c25dc6f5511f'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  softwareName  = 'WinSCP*'

  silentArgs    = '/VERYSILENT /ALLUSERS /NORESTART /DIR=C:\Program Files\WinSCP'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
