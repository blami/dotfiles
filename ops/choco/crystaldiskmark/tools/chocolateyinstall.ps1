$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://osdn.net/frs/redir.php?m=nchc&f=crystaldiskmark%2F77936%2FCrystalDiskMark8_0_4c.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'CrystalDiskMark*'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /DIR="C:\OC\CrystalDiskMark"'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
