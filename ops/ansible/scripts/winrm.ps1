#Requires -Version 2
#Requires -RunAsAdministrator

<#
.SYNOPSIS
  Setup WinRM remoting using a dedicated user and cert-based authentication
.DESCRIPTION
  This script sets up WinRM HTTPS listener, firewall and local user certificate
  mapping so that Ansible (and other tools) can remote in and manage Windows.

  This script is meant to reset everything everytime it runs as typical use is
  to invoke it from Ansible playbook *ONLY IF ANSIBLE IS UNABLE TO CONNECT*.
  Password of local user will be changed on every re-run to make sure the
  certificate mapping is valid.

  See: https://github.com/blami/dotfiles
.PARAMETER ServerCertPath
    Path to server certificate in .pfx format
.PARAMETER ClientCertPath
    Path to client certificate in .pfx format
.PARAMETER User
    Name of local user (created or modified by this script)
.PARAMETER FirewallIPs
    Comma-separated list of WinRM allowed source IPs
.PARAMETER FirewallIface
    Name of WinRM allowed source interface (e.g. vEthernet WSL)
.PARAMETER FirewallLocalSubnet
    Allow WinRM traffic only from local subnet
.PARAMETER FirewallRuleName
    Name of Windows Firewall rule
.PARAMETER Remove
    Will remove all existing setup based on given arguments

.NOTES
  Version:          1.0
  Author:           Ondrej Balaz
#>

param (
    [string]$ServerCertPath,
    [string]$ClientCertPath,
    [string]$User = "Ansible",
    [string]$FirewallIPs,
    [string]$FirewallIface,
    [switch]$FirewallLocalSubnet,
    [string]$FirewallRuleName = "Ansible WinRM HTTPS",
    [switch]$Remove
)

$ErrorActionPreference = "Stop"
# NOTE: Stop on error and wait for keypress (useful when run from Ansible)
Trap {
    $_
    Write-Host -ForegroundColor Red "An error occured. Press ENTER to exit."
    Read-Host
    Exit 1
}

# Variables

$Verb = "Installing"
if ($Remove) {
    $Verb = "Removing"
}


# Main

Write-Host -ForegroundColor DarkGreen @"
         _                          ___
 _    __(_)__  ______ _    ___  ___<  /
| |/|/ / / _ \/ __/  ' \_ / _ \(_-</ / 
|__,__/_/_//_/_/ /_/_/_(_) .__/___/_/  
                        /_/            
"@

# Certificates
Write-Host -ForegroundColor DarkGreen "* ${Verb} certificates"
# Server certificate
# NOTE: Can't use same code for server and client certificate as server
# certificate will not work if imported using X509Store.
Write-Host -ForegroundColor DarkYellow "> ${Verb} server certificate ${ServerCertPath}"
$ServerCert = Get-PfxCertificate -FilePath $ServerCertPath
if ($ServerCert.NotAfter -lt (Get-Date)) {
    Write-Error "Certificate $ServerCertPath is expired"
}
Remove-Item -Path cert:\LocalMachine\My\$ServerCert.Thumbprint -EA SilentlyContinue
if (!($Remove)) {
    $ServerCert = Import-PfxCertificate `
        -FilePath $ServerCertPath `
        -CertStoreLocation cert:\LocalMachine\My `
        -Password (New-Object -TypeName System.Security.SecureString)
}

# Client certificate
Write-Host -ForegroundColor DarkYellow "> ${Verb} client certificate ${ClientCertPath}"
$ClientCert = Get-PfxCertificate -FilePath $ClientCertPath
if ($ClientCert.NotAfter -lt (Get-Date)) {
    Write-Error "Certificate $ClientCertPath is expired"
}
foreach ($i in @("Root", "TrustedPeople")) {
    Remove-Item -Path cert:\LocalMachine\$i\$ClientCert.Thumbprint -EA SilentlyContinue
    if (!($Remove)) {
        $CertStore = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Store `
            -ArgumentList "$i", "LocalMachine"
        $CertStore.Open("MaxAllowed")
        $CertStore.Add($ClientCert)
        $CertStore.Close()
    }
}


# WinRM
Write-Host -ForegroundColor DarkGreen "* ${Verb} WinRM HTTPS listener"
# Service
if (!($Remove)) {
    Write-Host -ForegroundColor DarkYellow "> Configuring service"
    if (!(Get-Service "WinRM")) {
        Write-Error "WinRM service not found"
    }
    # NOTE: Make sure WinRM starts on boot
    Set-Service -Name "WinRM" -StartupType Automatic
    Start-Service -Name "WinRM"
    # NOTE: Make sure Windows itself can connect to WinRM
    Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WSMAN\Service -Name auth_negotiate -Value 1
    Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WSMAN\Service -Name auth_kerberos -Value 1
}

# Listeners
Write-Host -ForegroundColor DarkYellow "> ${Verb} HTTPS listener"
# TODO: Maybe this is too disruptive for e.g. Enterprise environment where
# other listeners might be used; redo this to optionally handle only own
# listener?
Remove-Item WSMan:\localhost\Listener\* -Recurse -EA SilentlyContinue
if (!($Remove)) {
    New-WSManInstance `
        -ResourceURI winrm/config/listener `
        -SelectorSet @{Address="*"; Transport="HTTPS"} `
        -ValueSet @{Hostname="localhost"; CertificateThumbprint=$ServerCert.Thumbprint}
    Write-Host -ForegroundColor DarkYellow "> Enabling certificate based authentication"
    # NOTE: Disable Basic auth
    # WARN: DO NOT DISABLE Negotiate OR Kerberos otherwise we lock ourselves out!
    Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $false
    Set-Item -Path WSMan:\localhost\Service\Auth\Certificate -Value $true
    # NOTE: This is required on Windows 10
    Write-Host -ForegroundColor DarkYellow "> Setting ClientAuthTrustMode to 2"
    Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL -Name ClientAuthTrustMode -Type DWord -Value 2
}


# Firewall
Write-Host -ForegroundColor DarkGreen "* ${Verb} Firewall Rules for WinRM HTTPS"
Remove-NetFirewallRule -DisplayName $FirewallRuleName -EA SilentlyContinue
if (!($Remove)) {
    $FirewallArgs = @{
        DisplayName = $FirewallRuleName
        Profile = "Any"
        Direction = "Inbound"
        LocalPort = "5986"
        Protocol = "TCP"
        Action = "Allow"
    }
    if ($FirewallIPs) { $FirewallArgs.LocalAddress = $FirewallIPs.Split(",") }
    if ($FirewallIface) { $FirewallArgs.InterfaceAlias = $FirewallIface }
    if ($FirewallLocalSubnet) { $FirewallArgs.RemoteAddress = @("LocalSubnet") }
    New-NetFirewallRule @FirewallArgs
}


# User
# NOTE: WinRM certificate mapping relies on target user password. If password
# of $User is changed after creating certificate mapping; the certificate needs
# to be remapped.
if (!($Remove)) {
    Write-Host -ForegroundColor DarkGreen "* Configuring local user ${User} for WinRM"

    # Create user
    # NOTE: If user exists change password so its known for certificate mapping
    Write-Host -ForegroundColor DarkYellow "> Creating local user"
    $UserCred = [PSCredential]::New(
        $User,
        $(ConvertTo-SecureString -AsPlainText -Force $(-join ((48..57) + (65..90) + (97..122) | Get-Random -Count 16 | ForEach-Object {[char]$_}))))
    try {
        Get-LocalUser -Name $User | Set-LocalUser -Password $UserCred.Password
    } catch {
        New-LocalUser `
            -Name $User `
            -Password $UserCred.Password `
            -PasswordNeverExpires
    }
    Write-Host -ForegroundColor DarkYellow "> Adding to Administrators group"
    Add-LocalGroupMember -Group "Administrators" -Member $User -EA SilentlyContinue
} else {
    # Remove user
    Write-Host -ForegroundColor DarkYellow "> Removing local user"
    Remove-LocalUser -Name $User -EA SilentlyContinue
}

# Certificate mapping
Write-Host -ForegroundColor DarkYellow "> ${Verb} certificate $($ClientCert.Thumbprint) mapping to ${User}"
Get-ChildItem -Path WSMan:\localhost\ClientCertificate -EA SilentlyContinue | Where-Object { $_.Keys -like "Issuer=$($ClientCert.Thumbprint)" } | Remove-Item -Recurse
if (!($Remove)) {
    New-Item -Path WSMan:\localhost\ClientCertificate `
        -Subject "${User}@localhost" `
        -URI * `
        -Issuer $ClientCert.Thumbprint `
        -Credential $UserCred `
        -Force `
}


Write-Host -ForegroundColor DarkGreen "Press ENTER to continue"
Read-Host
