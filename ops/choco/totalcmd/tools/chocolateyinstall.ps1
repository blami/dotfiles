$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://totalcommander.ch/1103/tcmd1103x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64         = $url64
  softwareName  = 'Total Commander*'

  # https://www.ghisler.ch/wiki/index.php?title=Installer#Description_of_switches_and_parameters
  silentArgs    = '/A1H1M0G1D0FN"*" C:\Program Files\TotalCmd'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
