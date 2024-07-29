$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = "https://update.code.visualstudio.com/1.91.1/win32-x64/stable"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Microsoft Visual Studio Code'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /MERGETASKS=!runcode,!desktopicon,!quicklaunchicon,!associatewithfiles /DIR=C:\Devel\vscode"

  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
