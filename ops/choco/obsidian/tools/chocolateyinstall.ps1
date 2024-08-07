$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.5/Obsidian-1.6.5.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64         = $url64
  softwareName  = 'Obsidian*'

  silentArgs    = '/S /D="C:\Program Files\Obsidian"'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

# Remove desktop icon
$desktop = [Environment]::GetFolderPath("DesktopDirectory")
if ($desktop) {
    Remove-Item -Path (Join-Path $desktop "Obsidian.lnk") -EA SilentlyContinue
}
