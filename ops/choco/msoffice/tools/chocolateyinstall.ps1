$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
# See: https://learn.microsoft.com/en-us/officeupdates/odt-release-history
$url      = "https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_17830-20162.exe"

@"
<Configuration>
    <Add OfficeClientEdition="64">
        <Product ID="ProPlusRetail">
            <Language ID="en-us" />
            <ExcludeApp ID="Access" />
            <ExcludeApp ID="OneDrive" />
            <ExcludeApp ID="Groove" />
            <ExcludeApp ID="Lync" />
            <ExcludeApp ID="OneNote" />
            <ExcludeApp ID="Outlook" />
            <ExcludeApp ID="Publisher" />
            <ExcludeApp ID="Teams" />
        </Product>
    </Add>
    <Updates Enabled="TRUE" />
    <Display Level="None" AcceptEULA="TRUE" />
    <Logging Level="Standard" Path="$toolsDir" />
</Configuration>
"@ | Out-File -FilePath "$toolsDir\Office2021ProPlus.xml"

# Extract deployment tool (setup.exe)
$packageArgs = @{
  packageName   = "msofficedeployment"
  fileType      = 'EXE'
  url           = $url

  silentArgs    = "/extract:$toolsDir /quiet /norestart"

  validExitCodes= @(0, 3010)
}
Install-ChocolateyPackage @packageArgs

# Install Microsoft Office
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file          = "$toolsDir\setup.exe"

  silentArgs    = "/configure $toolsDir\Office2021ProPlus.xml"

  validExitCodes= @(0, 3010)
}
Install-ChocolateyPackage @packageArgs
