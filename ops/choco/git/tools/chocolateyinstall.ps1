$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/Git-2.46.0-64-bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64         = $url64
  softwareName  = 'Git'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /NOCANCEL /COMPONENTS="icons,gitlfs" /o:PathOption=Cmd /DIR="C:\Devel\git"'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
