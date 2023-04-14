$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.imgburn.com/SetupImgBurn_2.5.8.0.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'ImgBurn*'

  silentArgs    = '/S'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
