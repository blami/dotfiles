$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://c2rsetup.officeapps.live.com/c2r/downloadVS.aspx?sku=community&channel=Release&version=VS2022'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Visual Studio'

  silentArgs    = '--quiet --norestart --wait --nocache --noUpdateInstaller --installPath C:\Devel\msvs --add Microsoft.VisualStudio.Workload.NativeDesktopproductArchx64'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
