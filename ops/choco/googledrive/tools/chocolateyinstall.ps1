$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl.google.com/drive-file-stream/GoogleDriveSetup.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Google Drive*'

  silentArgs    = '--silent --gsuite_shortcuts=false --skip_launch_new'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
