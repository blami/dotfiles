$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/vim/vim-win32-installer/releases/download/v9.1.0/gvim_9.1.0_x64_signed.zip'
# Short version used in install path
$ver        = ''
if ($url64 -match 'v([0-9]+).([0-9]+)') {
    $ver = "$($matches[1])$($matches[2])"
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = 'C:\Program Files\'
  url64         = $url64
}

$installArgs = @{
  # NOTE: Do not install desktop icons, do not create default vimrc
  statement     = '-create-batfiles vim gvim vimdiff gvimdiff -add-start-menu -install-openwith -install-popup'
  exeToRun      = "C:\Program Files\vim\vim$ver\install.exe"
}

Install-ChocolateyZipPackage @packageArgs
Start-ChocolateyProcessAsAdmin @installArgs
