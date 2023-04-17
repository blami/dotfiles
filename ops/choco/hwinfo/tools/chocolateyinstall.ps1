$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.hwinfo.com/files/hwi_742.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "C:\OC\HWiNFO"
  url           = $url
  softwareName  = 'HWiNFO*'

  # For download, Referer: HTTP header must be set
  options       = @{Headers = @{Referer = "https://www.hwinfo.com/download/"}}

  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -ShortcutFilePath "$($env:AppData)\Microsoft\Windows\Start Menu\Programs\HWiNFO64.lnk" -TargetPath "C:\OC\HWiNFO\HWiNFO64.exe" -RunAsAdmin
Install-ChocolateyShortcut -ShortcutFilePath "$($env:AppData)\Microsoft\Windows\Start Menu\Programs\HWiNFO32.lnk" -TargetPath "C:\OC\HWiNFO\HWiNFO32.exe" -RunAsAdmin
