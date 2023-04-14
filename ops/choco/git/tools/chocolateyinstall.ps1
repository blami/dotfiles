$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/git-for-windows/git/releases/download/v2.40.0.windows.1/Git-2.40.0-64-bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Git'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /NOCANCEL /COMPONENTS="icons,gitlfs" /o:PathOption=Cmd /o:EditorOption=CustomEditor /o:CustomEditorPath="C:\Program Files\Nvim\bin\nvim.exe" /DIR="C:\Program Files\Git"'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
