$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://installer.maxon.net/cinebench/CinebenchR23.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "C:\OC\Cinebench"
  url           = $url
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -ShortcutFilePath "$($env:AppData)\Microsoft\Windows\Start Menu\Programs\Cinebench.lnk" -TargetPath "C:\OC\Cinebench\Cinebench.exe" -RunAsAdmin
