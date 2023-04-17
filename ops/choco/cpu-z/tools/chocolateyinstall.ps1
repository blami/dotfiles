$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.cpuid.com/cpu-z/cpu-z_2.05-en.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'CPU-Z*'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /DIR="C:\OC\CPU-Z"'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
