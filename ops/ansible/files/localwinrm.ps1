# This is re-runable script that sets up WinRM with client certificate
# authentication and HTTPS self-signed certificate; so that $User can remote in
# from $Firewall networks.

# Reset
# winrm invoke Restore winrm/Config
# TODO: remove firewall rule
# TODO: remove certificates
# net stop winrm

# Expectations when remoting from WSL to hosting Windows are:
# - $Firewall is set to 127.0.0.1,172.0.0.0/8 (second item is for WSL2)
# - Every time client certificate mapping is required user has to input 
#   password interactively.

# Parameters
Param (
    [string]$CertDir = -join($env:USERPROFILE, "\.winrm"),  # certs location
    [string]$Firewall = "127.0.0.1,172.0.0.1/8"             # source IPs
)

# Error handling
Trap {
    $_
    Read-Host "Press ENTER to continue..."
    Exit 1
}
$ErrorActionPreference = "Stop"

# Set up WinRM listener on localhost with HTTPS self-signed certificate and
# certificate based authentication.
Function Setup-Listener {
    Write-Host "setting up WinRM listener"

    # Load, verify and add server certificate to store if needed.
    $CertPath = -join($CertDir, "\localserver.pfx")
    try {
        $Cert = Get-PfxCertificate -FilePath $CertPath
    } catch {
        Write-Error "unable to load certificate $CertPath $_"
    }
    if ($Cert.NotAfter -lt (Get-Date)) {
        Write-Error "certificate $CertPath is expired"
    }
    # Add certificate to My store
    if (!(Test-Path -Path cert:\LocalMachine\My\$($Cert.Thumbprint))) {
        Write-Host "adding Ansible server certificate"
        # NOTE: Don't use X509Store as in Setup-User. Certificate will not
        # work. Also overwrite $Cert as we refer to properties bellow.
        $Cert = Import-PfxCertificate `
            -FilePath $CertPath `
            -CertStoreLocation cert:\LocalMachine\My `
            -Password (New-Object -TypeName System.Security.SecureString)
    }
    Write-Host "server thumbprint", $Cert.Thumbprint

    # Setup WinRM service
    if (!(Get-Service "WinRM")) {
        Write-Error "WinRM service not found"
    }
    if ((Get-Service "WinRM").Status -ne "Running") {
        Write-Host "enabling WinRM service"
        Set-Service -Name "WinRM" -StartupType Automatic
        Start-Service -Name "WinRM" -ErrorAction Stop
    }

    # Check if localhost HTTPS listener called Ansible exists and if it matches
    # certificate thumbprint. If not, create it (delete existing listener if
    # any).

    try {
        $Listeners = Get-ChildItem WSMan:\localhost\Listener
    } catch {
        $Listeners = @()
    }

    # Remove HTTP listener if any
    if ($Listeners | Where-Object {$_.Keys -like "Transport=HTTP"}) {
        Write-Host "removing HTTP WinRM listener"
        Remove-WSManInstance `
            -ResourceURI winrm/config/listener `
            -SelectorSet @{Address="*"; Transport="HTTP"}
    }

    if (!($Listeners | Where-Object {$_.Keys -like "Transport=HTTPS"})) {
        Write-Host "creating HTTPS WinRM listener"
        New-WSManInstance `
            -ResourceURI winrm/config/listener `
            -SelectorSet @{Address="*"; Transport="HTTPS"} `
            -ValueSet @{Hostname="localhost"; CertificateThumbprint=$Cert.Thumbprint}
    }

    # Disable Basic and enable Certificate
    Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $false
    Set-Item -Path WSMan:\localhost\Service\Auth\Certificate -Value $true
}

# Set up firewall to either allow WinRM from certain addresses and networks
Function Setup-Firewall {
    Write-Host "setting up firewall for WinRM listener"

    try {
        Remove-NetFirewallRule -DisplayName "Ansible WinRM"
    } catch {}
    $LocalAddress = $null
    if ($Firewall) {
        $LocalAddress = $Firewall.split(",")
    }
    try {
        New-NetFirewallRule `
            -DisplayName "Ansible WinRM" `
            -Profile Any `
            -Direction Inbound `
            -LocalPort 5986  `
            -LocalAddress $LocalAddress `
            -Protocol TCP `
            -Action Allow
    } catch {
        Write-Error "unable to set up firewall $_"
    }
}

# Set up Ansible user as certificate authenticated WinRM user
Function Setup-User {
    Write-Host "setting up WinRM user"

    # Generate random password
    $Password = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 16 | ForEach-Object {[char]$_})
    $Credential = [PSCredential]::New(
        "Ansible",
        $(ConvertTo-SecureString -AsPlainText -Force $Password))
    Write-Host "user: Ansible, password: $Password"

    # Create user
    try {
        # Reset password to new one if user already exists
        Get-LocalUser -Name "Ansible" | Set-LocalUser -Password $Credential.Password
    } catch {
        # Create new user
        New-LocalUser `
            -Name $Credential.UserName `
            -Description "Ansible WinRM User" `
            -Password $Credential.Password `
            -PasswordNeverExpires `
    }
    # Add user to Administrators group
    # BUG: There's bug in Get-LocalGroupMember (see https://github.com/PowerShell/PowerShell/issues/2996)
    #if (Get-LocalGroupMember "Administrators").Name -contains $user
    Add-LocalGroupMember -Group "Administrators" -Member $Credential.UserName -ErrorAction SilentlyContinue

    # Load, verify and add client certificate to store if needed.
    $CertPath = -join($CertDir, "\localclient.crt")
    $Cert = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Certificate2
    try {
        $Cert.Import($CertPath)
    } catch {
        Write-Error "unable to load certificate $CertPath $_"
    }
    if ($Cert.NotAfter -lt (Get-Date)) {
        Write-Error "certificate $CertPath is expired"
    }
    $Cert.FriendlyName = "Ansible WinRM Client Certificate"
    # Add to Root CAs and Trusted People stores if not present
    foreach($I in @("Root", "TrustedPeople")) {
        if (!(Test-Path -Path cert:\LocalMachine\$I\$($Cert.Thumbprint))) {
            Write-Host "adding Ansible client certificate to $I"
            $Store = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Store `
                -ArgumentList "$I", "LocalMachine"
            $Store.Open("MaxAllowed")
            $Store.Add($Cert)
            $Store.Close()
        }
    }
    Write-Host "client thumbprint", $Cert.Thumbprint

    # Map client certificate to user
    $HasCert = Get-ChildItem -Path WSMan:\localhost\ClientCertificate | Where-Object { `
        $_.Keys -like "Subject=Ansible@localhost" -and `
        $_.Keys -like "Issuer=$($Cert.Thumbprint)" }
    if(!$HasCert) {
        New-Item -Path WSMan:\localhost\ClientCertificate `
            -Subject "$($Credential.UserName)@localhost" `
            -URI * `
            -Issuer $Cert.Thumbprint `
            -Credential $Credential `
            -Force
    }
}

Write-Host "configuring WinRM for Ansible"

Setup-Listener
Setup-Firewall
Setup-User

Read-Host "press ENTER to continue..."
