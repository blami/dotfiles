$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = "https://aka.ms/vs/17/release/vs_community.exe"

# See: https://learn.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community?view=vs-2022
@"
{
  "version": "1.0",
  "components": [
    "Microsoft.VisualStudio.Component.CoreEditor",
    "Microsoft.VisualStudio.Workload.CoreEditor",
    "Microsoft.Net.Component.4.8.SDK",
    "Microsoft.Net.Component.4.7.2.TargetingPack",
    "Microsoft.VisualStudio.Component.Roslyn.Compiler",
    "Microsoft.Component.MSBuild",
    "Microsoft.VisualStudio.Component.TextTemplating",
    "Microsoft.VisualStudio.Component.NuGet",
    "Microsoft.VisualStudio.Component.SQL.CLR",
    "Microsoft.VisualStudio.Component.AppInsights.Tools",
    "Microsoft.VisualStudio.Component.DiagnosticTools",
    "Microsoft.VisualStudio.Component.Debugger.JustInTime",
    "Microsoft.VisualStudio.Component.IntelliCode",
    "Microsoft.VisualStudio.Component.VC.CoreIde",
    "Microsoft.VisualStudio.Component.Windows10SDK",
    "Microsoft.VisualStudio.Component.VC.Tools.x86.x64",
    "Microsoft.VisualStudio.Component.Graphics.Tools",
    "Microsoft.VisualStudio.Component.VC.DiagnosticTools",
    "Microsoft.VisualStudio.Component.Windows11SDK.22621",
    "Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging",
    "Microsoft.VisualStudio.Component.VC.ATL",
    "Microsoft.VisualStudio.Component.SecurityIssueAnalysis",
    "Microsoft.VisualStudio.Component.VC.ATLMFC",
    "Microsoft.VisualStudio.Component.VC.Modules.x86.x64",
    "Microsoft.VisualStudio.Component.VC.Redist.14.Latest",
    "Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core",
    "Microsoft.VisualStudio.Component.Windows11Sdk.WindowsPerformanceToolkit",
    "Microsoft.VisualStudio.Component.CppBuildInsights",
    "Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake",
    "Microsoft.VisualStudio.Component.VC.CMake.Project",
    "Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest",
    "Microsoft.VisualStudio.Component.VC.ASAN",
    "Microsoft.VisualStudio.Component.Vcpkg",
    "Microsoft.VisualStudio.Component.VC.CLI.Support",
    "Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset",
    "Microsoft.VisualStudio.Component.VC.Llvm.Clang",
    "Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang",
    "Microsoft.VisualStudio.Component.VC.v141.x86.x64",
    "Microsoft.Component.VC.Runtime.UCRTSDK",
    "Microsoft.VisualStudio.Component.VC.140",
    "Microsoft.Component.NetFX.Native",
    "Microsoft.VisualStudio.Component.Graphics",
    "Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin",
    "Microsoft.VisualStudio.ComponentGroup.UWP.Support",
    "Microsoft.VisualStudio.Component.VC.Tools.ARM64EC",
    "Microsoft.VisualStudio.Component.UWP.VC.ARM64EC",
    "Microsoft.VisualStudio.Component.VC.Tools.ARM64",
    "Microsoft.VisualStudio.Component.UWP.VC.ARM64",
    "Microsoft.VisualStudio.Component.VC.Tools.ARM",
    "Microsoft.VisualStudio.ComponentGroup.UWP.VC",
    "Microsoft.VisualStudio.ComponentGroup.WindowsAppSDK.Cpp",
    "Microsoft.VisualStudio.Workload.NativeDesktop",
    "Microsoft.VisualStudio.Component.HLSL",
    "Microsoft.Component.HelpViewer",
  ],
  "extensions": []
}
"@ | Out-File -FilePath "$toolsDir\.vsconfig"


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url64         = $url64
  softwareName  = 'Microsoft Visual Studio*'

  silentArgs    = "install --installPath `"C:\Devel\msvs`" --quiet --force --norestart --config $toolsDir\.vsconfig"

  validExitCodes= @(0)
}

# NOTE: This will exit once MSVS Installer is installed and then will install
# in background.
Install-ChocolateyPackage @packageArgs
