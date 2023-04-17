$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://us3-dl.techpowerup.com/files/2eVHYgf_Qbl-VSo3V_Rksw/1681864874/GPU-Z.2.53.0.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  fileFullPath  = "C:\OC\GPU-Z\GPU-Z.exe"
}

Get-ChocolateyWebFile @packageArgs
Install-ChocolateyShortcut -ShortcutFilePath "$($env:AppData)\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -TargetPath "C:\OC\GPU-Z\GPU-Z.exe" -RunAsAdmin
