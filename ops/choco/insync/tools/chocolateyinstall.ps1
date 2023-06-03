$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://cdn.insynchq.com/builds/win/Insync-3.8.6.50504.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Insync*'
  silentArgs    = '/S' # /D=C:\Program Files\Insync BUG: InSync will not work if installed to Program Files
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
