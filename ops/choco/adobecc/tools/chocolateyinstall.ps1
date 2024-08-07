$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://prod-rel-ffc-ccm.oobesaas.adobe.com/adobe-ffc-external/core/v1/wam/download?sapCode=KCCC&wamFeature=nuj-live'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64         = $url64
  softwareName  = 'Adobe Creative Cloud'

  silentArgs    = '--mode=stub'

  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
# TODO: Wait for Creative Cloud to start and either minimize or taskill it.
