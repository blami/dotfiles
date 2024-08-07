$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://www.irfanview.info/files/iview462_x64_setup.exe'
$checksum64 = 'd9d4c5f3120a9420e2dbaf0ee8931556e161787fbc4297d5fb4e4c7616fdd668'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64         = $url64
  checksum64    = $checksum64
  checksumType  = 'sha256'
  softwareName  = 'Irfan View*'

  silentArgs    = '/silent /desktop=0 /thumbs=0 /group=1 /allusers=1 /assoc=1 /folder="C:\Program Files\IrfanView" /ini="%APPDATA%\IrfanView"'

  # For download, Referer: HTTP header must be set
  options       = @{Headers = @{Referer = "https://www.irfanview.info/"}}

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
