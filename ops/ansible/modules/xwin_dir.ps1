#!powershell

# Create or remove directory or link to directory on Windows. Also convert
# prefix / to C:\ and /'s to \'s.

# Example:
# - xwin_dir:
#     path: "bar\baz"
#     prefix: "C:\foo"
#     state: "present"
#     move: "C:\Users\obalaz
#     link: "\\wsl.localhost\debian\baz"

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        path = @{ type = "path"; required = $true }
        state = @{ type = "str"; choices = "directory", "link", "absent", "skip"; default = "directory" }
        link = @{ type = "path" }
        force = @{ type = "bool"; default = $false }
    }
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

# NOTE: Convert slashes to backslashes so same set of directories can be used
# across OSes when e.g. building /home dir.
$path = $module.Params.path
$prefix = $module.Params.prefix
$state = $module.Params.state
$link = $module.Params.link
$force = $module.Params.force

$module.Result.changed = $false

# Check if file exists and what attributes it has.
$p = Get-Item -Path $path -EA SilentlyContinue
$is_dir = if ($p) { $p.Attributes -band [System.IO.FileAttributes]::Directory } else { $false }
$is_link = if ($p) { $p.Attributes -band [System.IO.FileAttributes]::ReparsePoint } else { $false }

# Validations
if ($p -and !($is_dir) -and !($is_link)) {
    $module.FailJson("path $p exists but is neither directory nor link")
}
if ($p -and ($state -eq "directory") -and !$is_dir) {
    $module.FailJson("path $p exists but is not directory")
}
if ($p -and ($state -eq "link") -and !$is_link) {
    $module.FailJson("path $p exists but is not link")
}
if ($state -eq "link" -and !$link) {
    $module.FailJson("link property cannot be empty")
}

if ($state -eq "skip") {
    # Do nothing, just skip the directory
} elseif ($state -eq "absent") {
    if ($p) {
        Remove-Item -Path $p -Recurse
        $module.Result.changed = $true
    }
} else {
    if (!$p) {
        # NOTE: Do not create directory/link if its parent directory does not
        # exist without force: $true.
        if (!$force -and !(Test-Path -Path (Split-Path -Path $path) -PathType Container)) {
            $module.FailJson("unable to create $path; parent directory does not exist")
        }

        # NOTE: Assign to $p so we can refer to newly created item below.
        if ($state -eq "directory") {
            $p = New-Item -Path $path -ItemType Directory
        }
        if ($state -eq "link") {
            $p = New-Item -Path $path -Target $link -ItemType SymbolicLink -EA SilentlyContinue
        }
        $module.Result.changed = $true
    } else {
        # NOTE: This is in branch where $p existed before (and should exist)
        # as there's no point in running these on things we just created.

        # Fix wrong link
        # NOTE: \\ gets translated to UNC\ by Windows
        if ($p -and $is_link -and (($p.Target -replace "^UNC\\","\\") -ne $link)) {
            $p = New-Item -Path $path -Target $link -ItemType SymbolicLink -Force -EA SilentlyContinue
            $module.Result.changed = $true
        }
        # Fix letter case
        $Name = (Get-ChildItem -Path (Split-Path -Path $p) | Where-Object { $_ -like (Split-Path -Path $path -Leaf) }).Name
        if ((Split-Path -Path $path -Leaf) -cne $Name) {
            # Rename to temporary name
            Rename-Item -Path $p -NewName ($p.FullName + ".ansible-56d1199c")
            Rename-Item -Path ($p.FullName + ".ansible-56d1199c") -NewName $path
            $module.Result.changed = $true
        }
    }
}

$module.ExitJson()
