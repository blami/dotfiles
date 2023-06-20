#!powershell

# Install desktop.ini with given options to given path.

# Example:
# - xwin_desktop_ini:
#     path: C:\\Dir
#     icon: D:\\file.dll,32
#     info: "Foo bar"
#     state: "present"

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        path = @{ type = "path"; required = $true }
        icon = @{ type = "str" }
        info = @{ type = "str" }
        state = @{ type = "str"; choices = "absent", "present"; default = "present" }
    }
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

Function Read-Ini($path) {
    $ini = @{}
    $lines = Get-Content -Path $path -ErrorAction SilentlyContinue
    if (-not($lines)) { $lines = @() }

    $section = $null
    foreach ($line in $lines) {
        if($line -match "^(\[(?<section>.+)\]|(?<key>[^\[\]=]+)=(?<value>.+))$") {
            if ($Matches.section) {
                $section = $Matches.section
                $ini[$section] = @{}
            }
            if ($Matches.key) {
                if (-not($section)) { Write-Host "Error" }
                $ini[$section][$Matches.key] = $Matches.value
            }
        }
    }
    return $ini
}

Function Write-Ini($path, $ini) {
    $lines = @()
    foreach ($section in $ini.Keys) {
        $lines += ""
        $lines += "[$section]"
        foreach ($key in $ini[$section].Keys) {
            $value = $ini[$section][$key]
            $lines += "$key=$value"
        }
    }
    $lines += ""
    Set-Content -Path $path -Value $lines -Encoding Unicode -Force
}

$path = Get-Item $module.Params.path -ErrorAction SilentlyContinue
$icon = $module.Params.icon
$info = $module.Params.info
$state = $module.Params.state

$module.Result.changed = $false

if ((-not ($path)) -or (-not ($path.Attributes.HasFlag([IO.FileAttributes]::Directory)))) {
    $module.FailJson("$($path.FullName)) does not exist or is not a directory")
}
$ini_path = Join-Path -Path $path -ChildPath "desktop.ini"

if ($state -eq "absent") {
    if (Test-Path -Path $ini_path) {
        # desktop.ini removal seems to be fine without Shell.Application
        Remove-Item -Path $ini_path -Force
        $module.Result.changed = $true
    }
} else {
    $ini = Read-Ini $ini_path
    if (-not($ini.Keys -contains ".ShellClassInfo")) { $ini[".ShellClassInfo"] = @{} }
    if ($icon -and ($ini[".ShellClassInfo"]["IconResource"] -ne $icon)) { 
        $ini[".ShellClassInfo"]["IconResource"] = $icon
        $module.Result.changed = $true
    }
    if ($info -and ($ini[".ShellClassInfo"]["InfoTip"] -ne $info)) {
        $ini[".ShellClassInfo"]["InfoTip"] = $info
        $module.Result.changed = $true
    }
    # BUG: This is potential race condition if module runs in parallel
    $tmp_path = Join-Path $env:TEMP "desktop.ini"
    Write-Ini $tmp_path $ini

    # Required by explorer.exe to pick up desktop.ini
    (Get-Item -Path $path -Force).Attributes = "Readonly","Directory"
    (Get-Item -Path $tmp_path -Force).Attributes = "Archive","Hidden","System"

    # Move tmp file to desktop.ini
    $shell = New-Object -ComObject Shell.Application
    $path_shell = $shell.Namespace($path.FullName)
    $path_shell.MoveHere($tmp_path)
    $r = [System.Runtime.Interopservices.Marshal]::ReleaseComObject($shell)
}

$module.ExitJson()
