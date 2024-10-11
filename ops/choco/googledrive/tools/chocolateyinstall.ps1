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

# Advanced configuration
mkdir -force HKCU:\Software\Google\DriveFS > $null
Set-ItemProperty HKCU:\Software\Google\DriveFS DefaultMountPoint "%USERPROFILE%\AppData\GoogleDrive" -Type ExpandString
Set-ItemProperty HKCU:\Software\Google\DriveFS AutomaticErrorReporting 0
Set-ItemProperty HKCU:\Software\Google\DriveFS PromptToBackupDevices 0
Set-ItemProperty HKCU:\Software\Google\DriveFS SearchHotKey 0

Install-ChocolateyPackage @packageArgs
