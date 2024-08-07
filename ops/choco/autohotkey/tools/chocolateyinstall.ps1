$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://www.autohotkey.com/download/ahk-v2.exe'
$file64     = "$(Join-Path $toolsDir 'ahk-v2.exe')"

# TODO: 64bit vs ARM
# Add Defender exclusion and download installer
Add-MpPreference -ExclusionPath $file64
Get-ChocolateyWebFile -PackageName $env:ChocolateyPackageName `
                      -Url $url64 -FileFullPath $file64

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file64        = $file64
  softwareName  = 'AutoHotkey*'

  silentArgs    = '/silent /installto "C:\Program Files\AutoHotkey'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

# Remove Defender exclusion and installer
Remove-MpPreference -ExclusionPath $file64
Remove-Item $file64
