#!powershell

# Install TrueType and OpenType fonts to either user's LocalAppData or to
# system directory (C:\Windows\Fonts).

# Example:
# - xwin_font:
#     path: D:\\Fonts\\font.ttf
#     per_user: true

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        path = @{ type = "path"; required = $true }
        per_user = @{ type = "bool"; default = $true }
        # TODO: state = @{ type = "str"; choices = "absent", "present" }
    }
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$src = Get-Item -Path $module.Params.path
$per_user = $module.Params.per_user

# Check if fonts have .ttf or .otf extension
if (@(".ttf", ".otf") -notcontains $src.Extension) {
    $module.FailJson("unknown font extension: $($src.Extension)")
}

$shell = New-Object -ComObject shell.application
$src_dir = $shell.Namespace($src.DirectoryName)
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($shell) | Out-Null

$font_name = $src_dir.GetDetailsOf($src_dir.Items().Item($src.Name), 21)
switch ($src.Extension) {
    ".ttf" { $font_name = "$font_name (TrueType)" }
    ".otf" { $font_name = "$font_name (OpenType)" }
}

$dest = "$($Env:LocalAppData)\Microsoft\Windows\Fonts"
$reg_path = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
if (-not ($per_user)) {
    $dest = "$($Env:windir)\Fonts"
    $reg_path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
}
$dest = "$dest\$($src.Name)"

$module.Result.name = $font_name
$module.Result.path = $dest
$module.Result.registry = "$reg_path\$font_name"

if (-not (Test-Path -Path $dest)) {
    Copy-Item -Path $src.FullName -Destination $dest -Force
    $module.Result.changed = $true
}
if (-not (Get-ItemProperty -Path $reg_path -Name $font_name -ErrorAction SilentlyContinue)) {
    if (-not (Test-Path -Path $reg_path)) {
        # NOTE: Workaround using $r to avoid CLIXML output on stderr
        $r = New-Item -Path $reg_path -Force
    }
    # NOTE: Workaround using $r to avoid CLIXML output on stderr
    $r = New-ItemProperty -Path $reg_path -Name $font_name -Value $dest -PropertyType string -Force
    $module.Result.changed = $true
}

$module.ExitJson()
