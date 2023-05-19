$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/msys2/msys2-installer/releases/download/2023-03-18/msys2-x86_64-20230318.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'MSYS2*'

  silentArgs    = 'install --root C:\Devel\msys2 --confirm-command'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
