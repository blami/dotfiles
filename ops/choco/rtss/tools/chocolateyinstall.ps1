$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://ftp.nluug.nl/pub/games/PC/guru3d/afterburner/%5BGuru3D.com%5D-RTSS.zip'

# Download zip file and extract setup
$zipFile    = "$(Join-Path $toolsDir 'rtss.zip')"
$unzipDir   = "$(Join-Path $toolsDir 'setup')"
Get-ChocolateyWebFile -PackageName $env:ChocolateyPackageName `
                      -Url $url -FileFullPath $zipFile
Get-ChocolateyUnzip -PackageName $env:ChocolateyPackageName `
                    -FileFullPath $zipFile -Destination $unzipDir
# Find setup executable
$file       = (Get-ChildItem -Path $unzipDir -Filter '*RTSSSetup*.exe')[0].FullName

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  softwareName  = 'RivaTuner Statistics Server*'
  file          = $file
  silentArgs    = '/S /D=C:\OC\RTSS'

  validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# Remove downloaded and extracted files
Remove-Item $zipFile
Remove-Item $unzipDir -Recurse
