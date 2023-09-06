$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/msys2/msys2-installer/releases/download/2023-03-18/msys2-x86_64-20230318.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'MSYS2*'

  silentArgs    = 'install --root C:\Devel\msys2 --confirm-command'

  validExitCodes= @(0)
}

function Invoke-MSys2($Command) {
    $params = @{
        FilePath    = "C:\Devel\msys2\msys2_shell.cmd"
        NoNewWindow = $true
        Wait        = $true
        ArgumentList = "-defterm", "-no-start", "-c", "`"$Command`""
    }
    Write-Host "Running MSYS2 command:" $params.ArgumentList
    Start-Process @params
}

Install-ChocolateyPackage @packageArgs
Invoke-Msys2 "pacman --noconfirm -Syuu"
Invoke-Msys2 "pacman --noconfirm -S mingw-w64-i686-toolchain mingw-w64-x86_64-toolchain"
