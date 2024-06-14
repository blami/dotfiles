$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.autohotkey.com/download/ahk-v2.exe'
$file       = "$(Join-Path $toolsDir 'ahk-v2.exe')"

# Add Defender exclusion and download installer
Add-MpPreference -ExclusionPath $file
Get-ChocolateyWebFile -PackageName $env:ChocolateyPackageName `
                      -Url $url -FileFullPath $file

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file          = $file
  softwareName  = 'AutoHotkey*'

  silentArgs    = '/silent /installto "C:\Program Files\AutoHotkey'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

# Remove Defender exclusion and installer
Remove-MpPreference -ExclusionPath $file
Remove-Item $file
