$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.blender.org/release/Blender3.5/blender-3.5.1-windows-x64.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  softwareName  = 'blender*'
  silentArgs    = '/qn /norestart ALLUSERS=1 INSTALL_ROOT="C:\Program Files\blender\"'
  validExitCodes= @(0, 1641, 2010)
}

Install-ChocolateyPackage @packageArgs
