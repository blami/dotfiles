$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

(Invoke-WebRequest -URI "https://get.videolan.org/vlc/last/win64/").Content -match 'vlc-([0-9]+\.[0-9]+\.[0-9]+)-win64.exe'
$url        = "https://get.videolan.org/vlc/last/win64/vlc-$($matches[1])-win64.exe"

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
