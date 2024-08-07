$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://www.python.org/ftp/python/3.12.5/python-3.12.5-amd64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64         = $url64
  softwareName  = 'Python 3*'

  silentArgs    = '/quiet InstallAllUsers=1 PrependPath=0 TargetDir="C:\Devel\python3"'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
