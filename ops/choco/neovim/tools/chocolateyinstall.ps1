$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  softwareName  = 'Neovim*'

  silentArgs    = '/qn /norestart ALLUSERS=1 INSTALL_ROOT="C:\Program Files\Nvim"'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
