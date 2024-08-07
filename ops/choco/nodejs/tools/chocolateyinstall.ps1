$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://nodejs.org/dist/v20.16.0/node-v20.16.0-x64.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url64         = $url64
  softwareName  = 'Node.js*'

  silentArgs    = '/qn /norestart INSTALLDIR="C:\Devel\nodejs"'

  validExitCodes= @(0, 3010, 1641)
}

# Set PATH and NODE_PATH to ~\.local\nodejs
# NOTE: On Windows binaries are put directly to prefix and not to bin\
Install-ChocolateyEnvironmentVariable "NODE_PATH" "%USERPROFILE%\.local\nodejs\lib\node_modules" -VariableType User
Install-ChocolateyPath "%USERPROFILE%\.local\nodejs" -PathType User

Install-ChocolateyPackage @packageArgs
# Configure NPM prefix
& C:\Devel\nodejs\npm.cmd config set prefix "$($env:USERPROFILE)\.local\nodejs"
