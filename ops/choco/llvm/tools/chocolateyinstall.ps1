$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.3/LLVM-16.0.3-win64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'llvm*'

  silentArgs    = '/S /D=C:\Devel\llvm'

  validExitCodes= @(0)
}

# TODO: Perhaps add to PATH as NSIS cannot do that?

Install-ChocolateyPackage @packageArgs
