$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://get.videolan.org/vlc/3.0.18/win64/vlc-3.0.18-win64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'VLC media player*'

  silentArgs    = '/S'

  validExitCodes= @(0, 1223)
}

# Install to C:\Program Files\VLC instead of VideoLAN\VLC
mkdir -force HKLM:\Software\VideoLAN\VLC
Set-ItemProperty HKLM:\Software\VideoLAN\VLC InstallDir "C:\Program Files\VLC"

Install-ChocolateyPackage @packageArgs
