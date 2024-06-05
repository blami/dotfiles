#Requires -Version 2
#Requires -RunAsAdministrator

<#
.SYNOPSIS
  Custom bootstrap of WSL and Windows Terminal
.DESCRIPTION
  This script initializes basic WSL + Windows Terminal environment so Ansible
  can be kicked off inside the WSL (-Ansible) and setup the computer.

  Ansible playbook in https://github.com/blami/dotfiles/tree/main/ops/ansible
  is WSL aware and will setup WinRM connection to Windows host and setup rest
  of Windows and use Chocolatey packages to install Windows software.

  See: https://github.com/blami/dotfiles
.PARAMETER Distro
    Name of distribution (in wsl --list)
.PARAMETER DistroUri
    URI of distribution rootfs image
.PARAMETER DistroUser
    Name of default user of distribution when logging into it (not created automatically!)
.PARAMETER DistroCommands
    List of commands to execute as root when distro is installed.
    NOTE: %VARIABLE% placeholders for variables can be used, these are evaluated at execution.
.PARAMETER Ansible
    Whether or not to run AnsibleCommands after distro is installed.
.PARAMETER AnsibleBranch
    Name of git branch that can be used in AnsibleCommands when checking out playbook repo.
.PARAMETER AnsibleMyUser
    Name of user passed to playbook as -e user=... (not user Ansible is run as!)
.PARAMETER AnsibleCommands
    List of commands to execute as root to run Ansible.
    NOTE: %VARIABLE% placeholders for variables can be used, these are evaluated at execution.
.PARAMETER Proxy
    In case proxy is needed inside the WSL this will be exported as http_proxy= and https_proxy= before each 
    command.
.INPUTS
  <Inputs if any, otherwise state None>
.OUTPUTS
  <Outputs if any, otherwise state None - example: Log file stored in C:\Windows\Temp\<name>.log>
.NOTES
  Version:        1.0
  Author:         Ondrej Balaz


  
  This script is meant for Windows 10 (build >) and Windows 11 so far.

  This script can be run multiple times (even with same -Distro name) in non-destructive manner (unles -Force is set).

  There is no point in detecting arch as naming wildly differs not only
  between Windows an Linux; but also on Windows (AMD64 vs x64). To 
  install on arch other than AMD64 simply set different -DistroUri and
  -WSLUpdateUri.
.TODO
  Proxy support...
  
.EXAMPLE
  Powershell -ExecutionPolicy Bypass -Command "&{ .\wsl.ps1 }"
  Powershell -ExecutionPolicy Bypass -Command "&{ .\wsl.ps1 -Distro redhat -DistroCommands 'yum update' -Ansible }"

  NOTE: -Command "&{ ... }" is required to avoid issues with cmd.exe/powershell.exe array parsing.
#>

param (
    # WSL
	[string]$WSLDistro = "debian",
	[string]$WSLDistroUri = "https://github.com/debuerreotype/docker-debian-artifacts/raw/dist-amd64/testing/rootfs.tar.xz",
	[string]$WSLDistroUser = $env:USERNAME,
	[string[]]$WSLDistroCommands = @(
		"DEBIAN_FRONTEND=noninteractive ; apt-get -o Acquire::ForceIPv4=true update && apt-get -o Acquire::ForceIPv4=true install -y systemd systemd-sysv systemd-timesyncd systemd-resolved libnss-systemd libpam-systemd sudo zsh git"
	),
	[string]$WSLUpdateUri = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_amd64.msi",
	[string]$WSLDir = "$env:USERPROFILE\wsl",
	[string]$WSLName = (Get-Culture).TextInfo.ToTitleCase($WSLDistro),
	[string]$WSLIconUri = "https://raw.githubusercontent.com/blami/dotfiles/main/.local/share/pixmaps/debian.ico",
	[string]$WSLCommandLine = "",
	[switch]$Ansible = $false,
	[string[]]$AnsibleCommands = @(
		"DEBIAN_FRONTEND=noninteractive ; apt-get -o Acquire::ForceIPv4=true update && apt-get -o Acquire::ForceIPv4=true install -y python3-apt python3-winrm ansible",
		"rm -rf /tmp/dotfiles ; git clone --depth 1 https://github.com/blami/dotfiles.git /tmp/dotfiles"
		"cd /tmp/dotfiles/ops/ansible ; LC_ALL=C.utf-8 ansible-playbook play.yml -e `"user=%WSLDistroUser% bootstrapps1=1`""
	),
    [string]$Proxy = "",
    [string]$NoProxy = "",
	[switch]$Default,
	[switch]$Force
)

$ErrorActionPreference = "Stop"

# Functions

function Invoke-Commands {
	<#
	.SYNOPSIS
  	  Invoke given list of shell commands in given distribution, optionally substitute variables.
	.PARAMETER Distro
	    Name of WSL distribution to run commands in.
	.PARAMETER User
    	Name of user account to run commands as
	.PARAMETER Commands
    	List of shell commands distro. Any word prefixed with % is variable.
	#>
	param (
		[string]$WSLDistro = $WSLDistro,
		[string]$User = "root",
		[string[]]$Commands
	)

    $ProxyEnv = ""
    if ($Proxy -ne "") {
        $ProxyEnv = "export http_proxy=${Proxy} ; export https_proxy=${Proxy} ; "
    }
    if ($NoProxy -ne "") {
        $ProxyEnv += "export no_proxy=${NoProxy} ; "
    }

	foreach ($Command in $Commands) {
		# Simple variable substitution
		$Command | Select-String '%(.*?)%' -AllMatches | ForEach-Object {
			# TODO: Error handling?
			$Name = $_.Matches.Groups[1]
			$Command = $Command.Replace("%$Name%", (Get-Variable -Name $Name).Value)
		}
		Write-Host -ForegroundColor DarkYellow "> Running $Command"
		& wsl -d $WSLDistro -u "$User" --exec bash -c "$(if ($Proxy) {"export http_proxy=${Proxy} https_proxy=${Proxy} ; "})$Command"
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Last command return code: ${LASTEXITCODE}"
            exit 1
        }
	}
}


# Main


Write-Host -ForegroundColor DarkGreen @"
   __             __      __                          ___
  / /  ___  ___  / /____ / /________ ____    ___  ___<  /
 / _ \/ _ \/ _ \/ __(_-</ __/ __/ _ `/ _ \_ / _ \(_-</ / 
/_.__/\___/\___/\__/___/\__/_/  \_,_/ .__(_) .__/___/_/  
                                   /_/    /_/            
"@

# Variables
$WSLDistroDir = Join-Path $WSLDir $WSLDistro


# Checks
Write-Host -ForegroundColor DarkGreen "* Checking Environment"
# Minimal Windows build for Windows Terminal
$WinVersion = [System.Environment]::OSVersion.Version
if (($WinVersion.Major -eq 10) -and ($WinVersion.Build -lt 19041)) {
    Write-Error "This script requires at least Windows 10 build 19041"
    exit 1
}


# WSL
# Enable Windows optional features
Write-Host -ForegroundColor DarkGreen "* Enabling Windows Optional Features"
$WinFeatRestart = $false
foreach ($WinFeatName in @(
		"Microsoft-Windows-Subsystem-Linux",
		"VirtualMachinePlatform")) {
	$WinFeat = Get-WindowsOptionalFeature -Online -FeatureName $WinFeatName
	if (!$WinFeat.State) {
		Write-Host -ForegroundColor DarkYellow "> Enabling $WinFeatName"
		$WinFeat = (Enable-WindowsOptionalFeature -Online -FeatureName $WinFeatName -NoRestart)
	}
	if ($WinFeat.RestartNeeded) {
		$WinFeatRestart = $true
	}
}
if ($WinFeatRestart) {
	if($Host.UI.PromptForChoice(
		"Reboot is required in order to continue WSL installation. Re-run script after reboot.",
		"Do you want to reboot now?", @("&Yes", "&No"), 0) -eq 0) {
		# NOTE: Avoiding Restart-Computer as it sometimes fails with "Invalid Class ." WMI error
		& shutdown /r /f /p /c "WSL installation"
		exit
	} else {
		exit
	}
}

# Install WSL Update
Write-Host -ForegroundColor DarkGreen "* Installing WSL Updates"
if (!(Get-Package -Name "Windows Subsystem for Linux Update")) {
	Write-Host -ForegroundColor DarkYellow "> Installing WSL Update MSI"
	Invoke-WebRequest -Uri $WSLUpdateUri -OutFile (Join-Path $env:TEMP (Split-Path -Path $WSLUpdateUri -Leaf))
	Invoke-Expression -Command "$(Join-Path $env:TEMP (Split-Path -Path $WSLUpdateUri -Leaf)) /quiet"
}
Write-Host -ForegroundColor DarkYellow "> Updating WSL"
& wsl --update --web-download

# Install Latest USBIPD-Win
Write-Host -ForegroundColor DarkGreen "* Installing usbipd-win"
# NOTE: Get-Package will -EA fail silently if usbipd-win is not installed at all
$USBIPDVersion = (Split-Path -Path (Invoke-WebRequest "https://github.com/dorssel/usbipd-win/releases/latest" -MaximumRedirection 0 -ErrorAction Ignore).Headers.Location -Leaf).TrimStart("v")
if ((Get-Package -Name usbipd-win -EA SilentlyContinue).Version -lt [System.Version]$USBIPDVersion) {
	Write-Host -ForegroundColor DarkYellow "> Installing v$USBIPDVersion"
	$USBIPDUpdateUri = "https://github.com/dorssel/usbipd-win/releases/download/v${USBIPDVersion}/usbipd-win_${USBIPDVersion}.msi"
		Invoke-WebRequest -Uri $USBIPDUpdateUri -OutFile (Join-Path -Path $env:TEMP (Split-Path -Path $USBIPDUpdateUri -Leaf))
		Invoke-Expression -Command "$(Join-Path $env:TEMP (Split-Path -Path $USBIPDUpdateUri -Leaf)) /qn /norestart"
}

# Configure WSL
Write-Host -ForegroundColor DarkGreen "* Configuring WSL"
# Create .wslconfig
if (!(Test-Path -Path $env:USERPROFILE\.wslconfig) -or $Force) {
	Write-Host -ForegroundColor DarkYellow "> Creating ${env:USERPROFILE}\.wslconfig"
	Set-Content -Path $env:USERPROFILE\.wslconfig -Encoding UTF8 @"
[wsl2]
#memory=
#processors=
swap=0
kernelCommandLine=vsyscall=emulate
#dnsTunneling=true

[experimental]
autoMemoryReclaim=gradual
sparseVhd=true
"@
}
$(Get-Item -Path $env:USERPROFILE\.wslconfig -Force).Attributes += "Hidden"

# Configure WSL distribution
Write-Host -ForegroundColor DarkGreen "* Configuring WSL distribution"
# Install distribution
$WSLDistroExists = (wsl -l | where {$_.Replace("`0", "") -match "^$WSLDistro"}) -ne $null
if ($WSLDistroExists -and $Force) {
	Write-Host -ForegroundColor DarkYellow "> Forcing WSL distribution removal"
	& wsl --terminate $WSLDistro
	& wsl --unregister $WSLDistro
	Remove-Item -Path $WSLDistroDir -Recurse -Force -ErrorAction SilentlyContinue
	$WSLDistroExists = $false
}
if (!($WSLDistroExists)) {
	Write-Host -ForegroundColor DarkYellow "> Installing WSL distribution"
	if (!(Test-Path $WSLDistroDir)) {
		$_ = (New-Item -ItemType Directory -Path $WSLDistroDir)
	}
    $WSLDistroTarball = Join-Path $env:TEMP (Split-Path -Path $WSLDistroUri -Leaf)
    Invoke-WebRequest -Uri $WSLDistroUri -OutFile $WSLDistroTarball
	& wsl --import $WSLDistro $WSLDistroDir $WSLDistroTarball --version 2
	Remove-Item -Path $WSLDistroTarball -Force -ErrorAction SilentlyContinue

	Invoke-Commands -Distro $WSLDistro -User "root" -Commands $WSLDistroCommands
}
if ($Default) {
	Write-Host -ForegroundColor DarkYellow "> Setting WSL distribution as default"
	& wsl -s $WSLDistro
}
# TODO: This requires user to exist so its probably not great idea to do it here
#Write-Host -ForegroundColor DarkYellow "> Setting WSL distribution default user"
#$_ = (Get-ItemProperty -Path Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\*\ -Name DistributionName | Where-Object -Property DistributionName -eq $WSLDistro | Set-ItemProperty -Name DefaultUid -Value 1000


# Windows Terminal
# Install Latest Windows Terminal
Write-Host -ForegroundColor DarkGreen "* Installing Windows Terminal"
# NOTE: Get-AppxPackage will fail silently if Terminal is not installed at all
$WTVersion = (Split-Path -Path (Invoke-WebRequest "https://github.com/microsoft/terminal/releases/latest" -MaximumRedirection 0 -ErrorAction Ignore).Headers.Location -Leaf).TrimStart("v")
if ((Get-AppxPackage -Name Microsoft.WindowsTerminal).Version -lt [System.Version]$WTVersion) {
	Write-Host -ForegroundColor DarkYellow "> Installing v${WTVersion}"
	$choice = 0
	if ((Get-Process WindowsTerminal -EA SilentlyContinue) -ne $null) {
		$choice = $Host.UI.PromptForChoice(
			"Windows Terminal update will close all Windows Terminal windows.$(if ($env:WT_SESSION) {" Re-run script after update."})",
			"Do you want to continue, exit or skip the update?", @("&Continue", "&Exit", "&Skip"), 0)
		if ($choice -eq 1) {
			exit
		}
	}
	if ($choice -eq 0) {
		$WTUpdateUri = "https://github.com/microsoft/terminal/releases/download/v${WTVersion}/Microsoft.WindowsTerminal_${WTVersion}_8wekyb3d8bbwe.msixbundle"
		Invoke-WebRequest -Uri $WTUpdateUri -OutFile (Join-Path -Path $env:TEMP (Split-Path -Path $WTUpdateUri -Leaf))
		Add-AppxPackage -Path "$(Join-Path -Path $env:TEMP (Split-Path -Path $WTUpdateUri -Leaf))" -ForceApplicationShutdown
	}
}

# Setup Windows Terminal
$WSLIconPath = Join-Path -Path $WSLDistroDir "${WSLDistro}.ico"
if (!(Test-Path -Path $WSLIconPath) -or $Force) { 
	Invoke-WebRequest -Uri $WSLIconUri -OutFile $WSLIconPath
}
Write-Host -ForegroundColor DarkYellow "> Setting up Windows Terminal profile"
# See: https://learn.microsoft.com/en-us/windows/terminal/json-fragment-extensions
# NOTE: Do not touch settings.json as that is done via dotfiles
$WTProfilePath = Join-Path $env:USERPROFILE "AppData\Local\Microsoft\Windows Terminal\Fragments\$WSLDistro\${WSLDistro}.json"
if (!(Test-Path -Path $WTProfilePath) -or $Force) {
	Write-Host -ForegroundColor DarkYellow "> Creating profile fragment"
    $_ = (New-Item -Path $WTProfilePath -Force)
	Set-Content -Path $WTProfilePath -Encoding UTF8 @"
{
  "profiles": [
    {
      "name": "${WSLName}",
      "commandline": "wsl.exe -d $WSLDistro --cd ~",
      "icon": $($WSLIconPath | ConvertTo-Json)
    }  
  ]
}
"@
}

# Ansible
# Run Ansible
# NOTE: There are some Ansible tasks that will quit WSL2 (e.g. if /etc/wsl.conf is changed).
#       If these tasks touch %USERPROFILE%/.ansible-$WSLDistro.retry file we will delete it and
#       re-run Ansible.
if ($Ansible) {
    Write-Host -ForegroundColor DarkGreen "* Running Ansible"
	$AnsibleRetry = 1
	while ($AnsibleRetry -ge 1) {
		if ($AnsibleRetry -gt 1) {
			Write-Host -ForegroundColor DarkYellow "> Retry ${AnsibleRetry}"
		}
		Invoke-Commands -Distro $WSLDistro -User "root" -Commands $AnsibleCommands
		$AnsibleRetryPath = Join-Path -Path $env:USERPROFILE ".ansible/${WSLDistro}.retry"
		if (Test-Path -Path $AnsibleRetryPath) {
			Write-Host -ForegroundColor DarkYellow "> Retry file found, will re-run. Sleeping 5s"
			Remove-Item $AnsibleRetryPath
			$AnsibleRetry++
			Start-Sleep -Seconds 5
		} else {
			$AnsibleRetry = 0
		}
	}
}

Write-Host -ForegroundColor DarkGreen "* Bootstrap complete"
