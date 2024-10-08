﻿$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = "https://get.videolan.org/vlc/last/win64/vlc-3.0.21-win64.exe"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64         = $url64
  softwareName  = 'VLC media player*'

  silentArgs    = '/S'

  validExitCodes= @(0, 1223)
}

# Install to C:\Program Files\VLC instead of VideoLAN\VLC
mkdir -force HKLM:\Software\VideoLAN\VLC
Set-ItemProperty HKLM:\Software\VideoLAN\VLC InstallDir "C:\Program Files\VLC"

Install-ChocolateyPackage @packageArgs
