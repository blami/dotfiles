#!powershell

# (Un)pin Quick Access locations in Explorer.

# Example:
# - xwin_quick_access:
#     path: C:\\Dir
#     state: "present"

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        path = @{ type = "path"; required = $true }
        state = @{ type = "str"; choices = "absent", "present"; default = "present" }
    }
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$path = $module.Params.path
$state = $module.Params.state

$module.Result.changed = $false

$item = ((New-Object -Com Shell.Application).Namespace('shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}').Items() | Where-Object { $_.Path -eq $path })
if ($item -and ($state -eq "absent")) {
    $item.InvokeVerb("unpinfromhome")
    $module.Result.changed = $true
}
if (!$item -and ($state -eq "present")) {
    ((New-Object -Com Shell.Application).Namespace($path)).Self.InvokeVerb("pintohome")
    $module.Result.changed = $true
}

$module.ExitJson()
