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

function Read-Ini($path) {
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

function Write-Ini($path, $ini) {
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

$path = $module.Params.path
$dir = Get-Item $path -ErrorAction SilentlyContinue
$icon = $module.Params.icon
$info = $module.Params.info
$state = $module.Params.state

$module.Result.changed = $false

if ((-not ($dir)) -or (-not ($dir.Attributes.HasFlag([IO.FileAttributes]::Directory)))) {
    $module.FailJson("$path does not exist or is not a directory")
}
$ini_path = Join-Path -Path $dir -ChildPath "desktop.ini"

if ($state -eq "absent") {
    if (Test-Path -Path $ini_path) {
        # desktop.ini removal seems to be fine without Shell.Application
        Remove-Item -Path $ini_path -Force
        $module.Result.changed = $true
    }
} else {
    $ini = Read-Ini $ini_path
    if (-not($ini.Keys -contains ".ShellClassInfo")) { 
        $ini[".ShellClassInfo"] = @{}
        $module.Result.changed = $true
    }
    if ($icon) {
        if ($ini[".ShellClassInfo"]["IconResource"] -ne $icon) {
            $ini[".ShellClassInfo"]["IconResource"] = $icon
            $module.Result.changed = $true
        }
        # NOTE: Remove unwanted icon keys
        if (($ini[".ShellClassInfo"].Keys -contains "IconFile") -or ($ini[".ShellClassInfo"].Keys -contains "IconIndex")) {
            $ini[".ShellClassInfo"].Remove("IconFile")
            $ini[".ShellClassInfo"].Remove("IconIndex")
            $module.Result.changed = $true
        }
    }
    if ($info -and ($ini[".ShellClassInfo"]["InfoTip"] -ne $info)) {
        $ini[".ShellClassInfo"]["InfoTip"] = $info
        $module.Result.changed = $true
    }
    # NOTE: Remove localized resource name; show real name
    if ($ini[".ShellClassInfo"].Keys -contains "LocalizedResourceName") {
        $ini[".ShellClassInfo"].Remove("LocalizedResourceName")
        $module.Result.changed = $true
    }

    if ($module.Result.changed) {
        # BUG: This is potential race condition if module runs in parallel
        $tmp_path = Join-Path $env:TEMP "desktop.ini"
        Write-Ini $tmp_path $ini

        # Required by Explorer.exe to pick up desktop.ini
        (Get-Item -Path $dir -Force).Attributes = "Readonly","Directory"
        (Get-Item -Path $tmp_path -Force).Attributes = "Archive","Hidden","System"

        # Move tmp file to desktop.ini
        Remove-Item -Path (Join-Path -Path $dir -ChildPath "desktop.ini") -Force -EA SilentlyContinue
        $shell = New-Object -ComObject Shell.Application
        $path_shell = $shell.Namespace($dir.FullName)
        $path_shell.MoveHere($tmp_path)
        $r = [System.Runtime.Interopservices.Marshal]::ReleaseComObject($shell)
    }
}

$module.ExitJson()
