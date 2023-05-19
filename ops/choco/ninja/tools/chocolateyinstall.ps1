$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/ninja-build/ninja/releases/download/v1.11.1/ninja-win.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  unzipLocation = "C:\Devel\ninja"
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath -PathToInstall "C:\Devel\ninja" -PathType User
