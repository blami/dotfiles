#!powershell
# BUG: Unused $r = variable is to surpress output breaking Ansible

# Install cursor scheme to either user's LocalAppData or to system directory
# for all users. Cursors will be copied and renamed.

# Example:
# - xwin_cursor_scheme:
#     name: "Aero Black"
#     arrow: D:\\Cursors\\aero_arrow.cur
#     help:
#     wait:
#     busy:
#     cross:
#     ibeam:
#     pen:
#     no:
#     sizens:
#     sizewe:
#     sizenwse:
#     sizenesw:
#     sizeall:
#     uparrow:
#     hand:
#     pin:
#     person:
#     per_user: true    # Install to APPDATALOCAL
#     select: true      # Select scheme after installation
#     force: true       # Force overwrite files and registry keys
#     state: present    # Install/remove scheme (no paths needed when removing)

# NOTE: For meaning of each cursor name see: https://learn.microsoft.com/en-us/windows/win32/menurc/about-cursors

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        name = @{ type="str"; required = $true}
        arrow = @{ type="path" }
        help = @{ type="path" }
        wait = @{ type="path" }
        busy = @{ type="path" }
        cross = @{ type="path" }
        ibeam = @{ type="path" }
        pen = @{ type="path" }
        no = @{ type="path" }
        sizens = @{ type="path" }
        sizewe = @{ type="path" }
        sizenwse = @{ type="path" }
        sizenesw = @{ type="path" }
        sizeall = @{ type="path" }
        uparrow = @{ type="path" }
        hand = @{ type="path" }
        pin = @{ type="path" }
        person = @{ type="path" }
        per_user = @{ type="bool" ; default = $true }
        select = @{ type="bool" ; default = $false }
        force = @{ type="bool" ; default = $false }
        state = @{ type="str"; choices = "absent", "present"; default = "present" }
    }
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

Function Select-Scheme($name, $force) {
    $changed = $false
    $scheme = $null

    # Property names under Cursors registry key
    $idc = @("(default)", "Arrow", "Help", "AppStarting", "Wait", "CrossHair", "IBeam", "NWPen", "No", "SizeNS", "SizeWE", "SizeNWSE", "SizeNESW", "SizeAll", "UpArrow", "Hand", "Pin", "Person")

    # Find and parse scheme
    foreach ($p in @("HKCU:\Control Panel\Cursors\Schemes", "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes")) {
        # BUG: Get-ItemProperty will always expand REG_EXPAND_SZ
        if ($scheme = $(Get-ItemProperty -Path $p -Name $name -ErrorAction SilentlyContinue).$name) {
            break
        }
    }
    if (-not($scheme)) {
        $module.FailJson("scheme '$name' does not exist")
    }
    $scheme = @($name) + $scheme.Split(",")
    if ($scheme.Length -lt $idc.Length) {
        $module.FailJson("scheme '$name' is incomplete")
    }

    # Set scheme
    for ($i = 0; $i -lt $idc.Length; $i++) {
        $update = ((Get-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name $($idc[$i])).$($idc[$i]) -ne $scheme[$i])
        if($update -or $force) {
            $r = Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name $($idc[$i]) -Value "$($scheme[$i])"
            if ($update) { $changed = $true }
        }
    }

    # Advertise scheme change
    if ($changed -or $force) {
        $sig = '
            [DllImport("user32.dll", EntryPoint = "SystemParametersInfo")]
            public static extern bool SystemParametersInfo(
                uint uiAction,
                uint uiParam,
                uint pvParam,
                uint fWinIni);
            '
        $type = Add-Type -MemberDefinition $sig -Name WinAPICall -Namespace SystemParamInfo -PassThru
        $type::SystemParametersInfo(0x0057, 0, $null, 0)
    }
    return $changed
}

Function Add-Scheme($name, $cursors, $path, $reg, $force) {
    $changed = $false
    $prefix = $name.ToLower() -replace '\s+','_'

    # Copy and rename files
    if (-not(Test-Path -Path $path)) { $r = New-Item -Path $path -Type Directory }
    foreach ($k in $cursors.Keys) {
        $src = $cursors[$k]
        if (-not(Test-Path -Path $src)) {
            $module.FailJson("file $src does not exist")
        }
        $dest = Join-Path $path "$($prefix)_$($k)$([System.IO.Path]::GetExtension($src))"
        $update = (-not(Test-Path -Path $dest))
        if ($update -or $force) {
            $r = Copy-Item -Path $src -Destination $dest
            if ($update) { $changed = $true }
        }
    }

    # Add scheme to registry
    $regs = $(Join-Path $reg "Schemes")
    if (-not(Test-Path -Path $regs)) { $r = New-Item -Path $regs }
    $scheme = @()
    foreach ($k in $cursors.Keys) {
        $scheme += $(Join-Path $path "$($prefix)_$($k)$([System.IO.Path]::GetExtension($($cursors[$k])))")
    }
    $scheme = $scheme -join ','
    $update = ((Get-ItemProperty -Path $regs -Name $name -ErrorAction SilentlyContinue).$name -ne $scheme)
    if ($update -or $force) {
        $r = New-ItemProperty -Path $regs -Name $name -PropertyType ExpandString -Value $scheme
        if ($update) { $changed = $true }
    }

    return $changed
}

Function Remove-Scheme($name) {
    $scheme = $null
    $reg = $null
    foreach ($p in @("HKCU:\Control Panel\Cursors\Schemes", "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes")) {
        # BUG: Get-ItemProperty will always expand REG_EXPAND_SZ
        $scheme = $(Get-ItemProperty -Path $p -Name $name -ErrorAction SilentlyContinue).$name
        if ($scheme) {
            $reg = $p
            break
        }
    }

    if ($scheme) {
        # Remove files 
        $scheme = $scheme -split ','
        foreach ($f in $scheme) {
            if (Test-Path -Path $f) {
                $r = Remove-Item -Path $f
            }
        }

        # Remove registry key
        $r = Remove-ItemProperty -Path $reg -Name $name

        # If theme was set revert to Windows Aero
        if ((Get-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "(default)")."(default)" -eq $name) {
            $r = Select-Scheme "Windows Aero" $true
            $r = Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "(default)" -Value ""
        }

        return $true
    } else {
        return $false
    }
}


$name = $module.Params.name
# NOTE: [ordered] requires PowerShell 3, but whatever...
$cursors = [ordered]@{
     arrow = $module.Params.arrow 
     help = $module.Params.help
     wait = $module.Params.wait
     busy = $module.Params.busy
     cross = $module.Params.cross
     ibeam = $module.Params.ibeam
     pen = $module.Params.pen
     no = $module.Params.no
     sizens = $module.Params.sizens
     sizewe = $module.Params.sizewe
     sizenwse = $module.Params.sizenwse
     sizenesw = $module.Params.sizenesw
     sizeall = $module.Params.sizeall
     uparrow = $module.Params.uparrow
     hand = $module.Params.hand
     pin = $module.Params.pin
     person = $module.Params.person
}
$per_user = $module.Params.per_user
$select = $module.Params.select
$force = $module.Params.force
$state = $module.Params.state

$module.Result.changed = $false

if ($select -and ($state -eq "absent")) {
    $module.FailJson("unable to select removed scheme")
}

# BUG: Get-ItemProperty always expands REG_EXPAND_SZ anyway so no need to create %LOCALAPPDATA%\path style paths
$path = if ($per_user) { Join-Path $env:LOCALAPPDATA "Microsoft\Windows\Cursors" } else { Join-Path $env:SystemRoot "Cursors" }
$reg = if ($per_user) { "HKCU:\Control Panel\Cursors" } else { "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors" }

if ($state -eq "present") {
    $module.Result.changed = Add-Scheme $name $cursors $path $reg $force
    if ($select) {
        $module.Result.changed = (Select-Scheme $name $force) -or $module.Result.changed
    }
} else {
    # NOTE: Remove-Scheme handles reverting to 'Windows Aero'
    $module.Result.changed = Remove-Scheme $name
}

$module.ExitJson()
