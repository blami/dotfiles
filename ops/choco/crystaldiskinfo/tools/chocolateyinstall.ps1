$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://osdn.net/frs/redir.php?m=nchc&f=crystaldiskinfo%2F78192%2FCrystalDiskInfo8_17_14.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'CrystalDiskInfo*'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /DIR="C:\OC\CrystalDiskInfo"'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
