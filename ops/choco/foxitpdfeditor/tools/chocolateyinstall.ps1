$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32      = 'https://cdn01.foxitsoftware.com/product/phantomPDF/desktop/win/11.2.10/FoxitPDFEditor11210_enu_Setup_Website.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url32
  softwareName  = 'Foxit PDF Editor*'

  silentArgs    = '/install /quiet /norestart /noshortcut /DisableInternet /DIR "C:\Program Files (x86)\Foxit PDF Editor"'

  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
