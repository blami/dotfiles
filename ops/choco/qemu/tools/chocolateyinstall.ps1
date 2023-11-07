$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://qemu.weilnetz.de/w64/2023/qemu-w64-setup-20230822.exe'
$ovmfUrl    = 'https://sourceforge.net/projects/edk2/files/OVMF/OVMF-X64-r15214.zip/download'

# Download OVMF UEFI firmware
$zipFile    = "$(Join-Path $toolsDir 'ovmf.zip')"
$unzipDir   = "$(Join-Path $toolsDir 'ovmf')"
Get-ChocolateyWebFile -PackageName $env:ChocolateyPackageName `
                      -Url $ovmfUrl -FileFullPath $zipFile
Get-ChocolateyUnzip -PackageName $env:ChocolateyPackageName `
                    -FileFullPath $zipFile -Destination $unzipDir

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'QEMU*'
  silentArgs    = '/S /D=C:\Program Files\QEMU'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
Install-ChocolateyPath -PathToInstall "C:\Program Files\QEMU\" -PathType User

# Copy OVMF.fd
Copy-Item -Path "$(Join-Path $unzipDir OVMF.fd)" -Destination "C:\Program Files\QEMU\share\ovmf.fd"

# Remove downloaded and extracted files
Remove-Item $zipFile
Remove-Item $unzipDir -Recurse
