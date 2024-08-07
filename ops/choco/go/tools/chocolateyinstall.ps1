$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = "https://golang.org/dl/go1.22.5.windows-amd64.msi"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url64
  softwareName  = 'Go Programming Language*'

  silentArgs    = "/qn /norestart INSTALLDIR=`"C:\Devel\go`""

  validExitCodes= @(0, 3010, 1641)
}

# Set GOPATH to ~\.local\go for tools
Install-ChocolateyEnvironmentVariable "GOPATH" "%USERPROFILE%\.local\go" -VariableType User
Install-ChocolateyEnvironmentVariable "GO111MODULE" "auto" -VariableType User

Install-ChocolateyPackage @packageArgs
