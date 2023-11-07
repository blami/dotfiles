$ErrorActionPreference = 'Stop' # stop on all errors
$url        = 'https://go.dev/dl/go1.21.1.windows-amd64.zip'
$gopath     = Join-Path $env:USERPROFILE ".local\go"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  # NOTE: top level of archive is already "go"
  unzipLocation = "C:\Devel"
}

Install-ChocolateyPath -PathToInstall "C:\Devel\go\bin" -PathType User
Install-ChocolateyPath -PathToInstall "$(Join-Path $gopath 'bin')" -PathType User
Install-ChocolateyEnvironmentVariable "GOPATH" $gopath -VariableType User
Install-ChocolateyEnvironmentVariable "GO111MODULE" "auto" -VariableType User
Install-ChocolateyZipPackage @packageArgs
