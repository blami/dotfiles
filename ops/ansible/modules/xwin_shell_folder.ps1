#!powershell

# Relocate Windows KNOWNFOLDER 

# Example:
# - xwin_shellfolder:
#     guid: B4BFCC3A-DB2C-424C-B029-7FE99A87C641
#     path: %USERPROFILE%\\desk
#     move_files: false

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        guid = @{ type = "str"; required = $true }
        # NOTE: avoid expansion of variables
        path = @{ type = "str"; required = $true }
        move_files = @{ type = "bool"; default = $false }
    }
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

# Shell32 API helper to set folder path (updating registry itself is not enough)
if (-not ("WinAPI.KnownFolders" -as [type])) {
    Add-Type -Namespace "WinAPI" `
        -Name "KnownFolders" `
        -Language "CSharp" `
        -MemberDefinition @"
[DllImport("shell32.dll")]
public extern static int SHSetKnownFolderPath(ref Guid folderId, uint flags, IntPtr token, [MarshalAs(UnmanagedType.LPWStr)] string path);
"@
}

$reg_path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"

# GUIDs of KNOWNFOLDERS mapped to legacy registry key names.
# See: https://learn.microsoft.com/en-us/windows/win32/shell/knownfolderid
# NOTE: Missing ones are identity (key is {GUID}) or bug :)
$knownfolders = @{
    "3EB685DB-65F9-4CF6-A03A-E3EF65729F3D" = "AppData"
    "352481E8-33BE-4251-BA85-6007CAEDCF9D" = "Cache"    # XXX: might be wrong
    "2B0F765D-C0E9-4171-908E-08A611B84FF6" = "Cookies"
    "B4BFCC3A-DB2C-424C-B029-7FE99A87C641" = "Desktop"
    "1777F761-68AD-4D8A-87BD-30B759FA33DD" = "Favorites"
    "D9DC8A3B-B784-432E-A781-5A1130A75963" = "History"
    "F1B32785-6FBA-4FCF-9D55-7B8E7F157091" = "Local AppData"
    "4BD8D571-6D19-48D3-BE97-422220080E43" = "My Music"
    "33E28130-4E1E-4676-835A-98395C3BC3BB" = "My Pictures"
    "18989B1D-99B5-455B-841C-AB7C74E4DDFC" = "My Video"
    "C5ABBF53-E17F-4121-8900-86626FC2C973" = "NetHood"
    "FDD39AD0-238F-46AF-ADB4-6C85480369C7" = "Personal"
    "9274BD8D-CFD1-41C3-B35E-B13F55A758F4" = "PrintHood"
    "A77F5D77-2E2B-44C3-A6A2-ABA601054A51" = "Programs"
    "AE50C081-EBD2-438A-8655-8A092E34987A" = "Recent"
    "8983036C-27C0-404B-8F08-102D10DCFD74" = "SendTo"
    "625B53C3-AB48-4EC1-BA1F-A1EF4146FC19" = "Start Menu"
    "B97D20BB-F46A-4C97-BA10-5E3608430854" = "Startup"
    "A63293E8-664E-48DB-A079-DF759E0509F7" = "Templates"
}

# These GUIDs DO NOT EXIST in a clean install and once created they override
# location for original GUIDs. They are created by e.g. OneDrive or Dropbox.
$knownfolders_overrides = @{
    "FDD39AD0-238F-46AF-ADB4-6C85480369C7" = "F42EE2D3-909F-4907-8871-4C22FC0BF756" # Local Documents
    "374DE290-123F-4565-9164-39C4925E467B" = "7D83EE9B-2244-4E70-B1F5-5393042AF1E4" # Local Downloads
    "4BD8D571-6D19-48D3-BE97-422220080E43" = "A0C69A99-21C8-4671-8703-7934162FCF1D" # Local Music
    "33E28130-4E1E-4676-835A-98395C3BC3BB" = "0DDD015D-B06C-45D5-8C4C-F59713854639" # Local Pictures
    "18989B1D-99B5-455B-841C-AB7C74E4DDFC" = "35286A68-3C57-41A1-BBB1-0EAE73D76C95" # Local Videos
}

if (-not ([guid]::TryParse($module.Params.guid, $([ref][guid]::Empty)))) {
    $module.FailJson("invalid ShellFolder GUID: $($module.Params.guid)")
}

$guids = @($module.Params.guid)
if ($knownfolders_overrides.ContainsKey($guids[0])) {
    $guids += $knownfolders_overrides[$guids[0]]
}
$items = @{}
foreach ($guid in $guids) {
    $items[$guid] = if ($knownfolders.ContainsKey($guid)) { $knownfolders[$guid] } else { "{$guid}" }
}
$path = $module.Params.path
$move_files = $module.Params.move_files

foreach ($guid in $items.Keys) {
    $reg_key = $items[$guid]
    $reg = $(Get-Item -Path $reg_path)
    $cur_path = @($reg.GetValue($reg_key, "", 1), $reg.GetValue($reg_key))
    if ($cur_path[0] -ne $path) {
        # Relocate User Shell Folder
        $r = [WinAPI.KnownFolders]::SHSetKnownFolderPath([ref]$guid, 0, 0, $path)
        $r = New-ItemProperty -Path $reg_path -Name $reg_key -PropertyType ExpandString -Value $path -Force
        # Move files
        if ($move_files -and (Test-Path -Path $cur_path[1])) {
            $new_path = $(Get-Item -Path $reg_path).GetValue($reg_key)
            if (-not (Test-Path -Path $new_path)) {
                $module.FailJson("target directory $new_path does not exist")
            }
            try {
                Get-ChildItem -Path $cur_path[1] -Recurse | Move-Item -Destination $new_path
            } catch {
                $module.FailJson($_)
            }
        }
        $module.Result.changed = $true
    }
}

$module.ExitJson()
