$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.mersenne.org/download/software/v30/30.8/p95v308b17.win64.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "C:\OC\Prime95"
  url           = $url
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -ShortcutFilePath "$($env:AppData)\Microsoft\Windows\Start Menu\Programs\Prime95.lnk" -TargetPath "C:\OC\Prime95\prime95.exe" -RunAsAdmin
