# This is re-runable script that sets up WinRM with client certificate 
# authentication and HTTPS self-signed certificate; so that $User can remote in
# from $Firewall networks.

# Expectations when remoting from WSL to hosting Windows are:
# * $User is actually the same user as one running Ansible
# * $Firewall is set to 127.0.0.1,172.0.0.0/8 (second item is for WSL2)
# * Every time client certificate mapping is required user has to input 
#   password.

# Parameters
Param (
    [string]$User = $env:USERNAME,
    [string]$CertDir = -join($env:USERPROFILE, "\.winrm"),
    [string]$Firewall
)

# Error handling
Trap {
    $_
    Read-Host "Press ENTER to continue..."
    Exit 1
}
$ErrorActionPreference = "Stop"


# Functions

# Set up WinRM listener on localhost with HTTPS self-signed certificate and
# certificate based authentication.
Function Setup-Listener {
    Write-Host "setting up WinRM listener"

    # Load, verify and add server certificate to store if needed.
    $CertPath = -join($CertDir, "\server.pfx")
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

    # Disable all auth methods but ClientCertificate
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

# Set up given $User as certificate authenticated WinRM user
Function Setup-User {
    Write-Host "setting up WinRM user"

    # Check if user exists
    try {
        $AnsibleUser = Get-LocalUser $User
    } catch {
        Write-Error "user $User does not exist"
    }

    # Load, verify and add client certificate to store if needed.
    $CertPath = -join($CertDir, "\client.crt")
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

    # Map client certificate to user
    $HasCert = Get-ChildItem -Path WSMan:\localhost\ClientCertificate | Where-Object { `
        $_.Keys -like "Subject=$($AnsibleUser.Name)@localhost" -and `
        $_.Keys -like "Issuer=$($Cert.Thumbprint)" }
    if(!$HasCert) {
        # Obtain user password
        Write-Host "mapping client certificate to user"
        $PasswordPrompt = "password"
        if ($AnsibleUser.PrincipalSource -eq "MicrosoftAccount") {
            $PasswordPrompt = "Microsoft Account password"
        }

        $Credential = Get-Credential `
            -Message "Enter $PasswordPrompt to map client certificate" `
            -Username $AnsibleUser.Name
        New-Item -Path WSMan:\localhost\ClientCertificate `
            -Subject "$($AnsibleUser.Name)@localhost" `
            -URI * `
            -Issuer $Cert.Thumbprint `
            -Credential $Credential `
            -Force
    }
}


### Main

Write-Host "configuring WinRM for Ansible"

Setup-Listener
Setup-Firewall
Setup-User

# Read-Host "Press ENTER to continue..."
