﻿$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/Kitware/CMake/releases/download/v3.26.3/cmake-3.26.3-windows-x86_64.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  softwareName  = '*'

  silentArgs    = '/qn /norestart INSTALL_ROOT="C:\Devel\cmake\" ADD_CMAKE_TO_PATH="User"'

  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
