#!powershell

# Disable or enable startup apps by their name.

# - xwin_startup_app:
#     name: "Creative Cloud Updater.lnk"
#     enabled: false
#
# - xwin_startup_app:
#     name: "91750D7E.Slack_8she8kybcnzg4"
#     enabled: false

# In order to know _name_ either Explorer\StartupApproved registry keys need to
# be investigated or UWP package needs to be known (see AppData\Local\Packages
# and directory name is UWP package name).

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        name = @{ type = "string"; required = $true }
        enabled = @{ type = "bool"; required = $true }
    }
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$name = $module.Params.name
$enabled = $module.Params.enabled

Function Toggle-NonUWP($name, $enabled) {
    # These are registry paths Task Manager uses
    # NOTE: UWP apps use different mechanism (see below)
    $reg_paths = @(
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\StartupFolder",
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run",
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32",
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\StartupFolder",
    )

    # NOTE: 0x3 seems to disable just fine, so no need to bother with arrays...
    $changed = $false
    $value = if ($enabled) { 0x2 } else { 0x3 }
    foreach ($reg_path in $reg_paths) {
        if (-not(Test-Path -Path $reg_path)) { continue }
        if ($(Get-Item -Path $reg_path).Property.Contains($name)) {
            $o = Get-ItemProperty -Path $reg_path
            if ($($o.$name)[0] -ne $value) {
                Set-ItemProperty -Path $reg_path -Name $name -Type Binary -Value $value
                $changed = $true
            }
        }
    }

    return $changed
}

Function Toggle-UWP($name, $enabled) {
    $reg_path = "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\$name"
    if (-not(Test-Path -Path $reg_path)) { return }

    # Find key with State property...
    $reg_key = Get-ChildItem -Path $reg_path | Where {$_.Property -contains "State" -and $_.Property -contains "UserEnabledStartupOnce"}
    if ($reg_key -eq $null) { return $false }

    $reg_subkey = "$reg_path\$(reg_key.PSChildName)"
    # NOTE: Task Manager uses 0x2 for enabled and 0x1 for disabled
    $value = if ($enabled) { 0x2 } else { 0x1 }
    $o = Get-ItemProperty -Path $reg_subkey
    if ($o.State -ne $value) {
        $r = Set-ItemProperty -Path $reg_subkey -Name "State" -Type Dword -Value $value
        return $true
    }
    return $false
}

$changed = $false
$changed = Toggle-NonUWP($name, $enabled)
$changed = $changed -or Toggle-UWP($name, $enabled)

$module.Result.changed = $changed
$module.ExitJson()
