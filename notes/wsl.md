Windows Update
==============

Enable Insider Builds
---------------------
- Run gpedit.msc
- Go Local Computer Policy > Administrative Templates > Windows Components >
  Data Collection and Preview Builds
- Toggle user control over Insider builds to Enabled.


WSL Setup
=========

Notes
-----
LxRunOffline.exe    - manage multiple Linux distros (not using this)
wslconfig.exe       - WSL manager built in to windows
wsl.exe             - Default distro manager

Links
-----
https://docs.microsoft.com/en-us/windows/wsl/wsl-config

Install Ubuntu and setup user
-----------------------------
- Install Ubuntu (not Ubuntu X.Y) from Windows Store
- If you want different uid just create user `foo` and then create new real
  user, don't forget to add to sudo group! Changing user afterwards results
  in non-working WSL.
  - `# adduser`
  - Change default user in CMD `ubuntu config --default-user <user>`
  - `for g in adm dialout cdrom floppy sudo audio dip video plugdev netdev ; do
        addgroup obalaz $g
     done`
- If more distributions exists use CMD and do `wslconfig.exe /s Ubuntu`
- `$ sudo bash`
- `# echo 'Acquire::ForceIPv4 "true";' > /etc/apt/apt.conf.d/99force-ipv4`
- `# do-release-upgrade -d`
- Re-open as new user

Optionally configure /etc/wsl.conf to share directories outside WSL:

    [automount]
    enabled = true
    root = /mnt/
    options = "metadata,umask=2,fmask=1"
    mountFsTab = true

    [network]
    generateHosts = true
    generateResolvConf = true

- optionally chuser to move home to /mnt/c/Users/<WindowsUser>
- `# apt-get update && apt-get upgrade`
- `# apt-get install git vim-nox tmux ...`
- `$ umask 002 ; git clone github://dotfiles`

Docker for Windows communicating with WSL Docker
================================================
- In Windows Docker enable non-TLS port 2375
- Setup docker by exporting DOCKER_HOST to 'localhost'
- Disable port 2375 for external incoming connections to secure it

- Enable non-TLS port
- Go to Windows Defender Firewall with Advanced Security
    -> Inbound Rules
    -> Create New Rule
    -> Rule Type: Port
    -> TCP, 2375
    -> Allow the connection if it is secure


Issues
======
- Executable stack issue: ``cannot enable executable stack as shared object
  requires: Invalid argument``
  - ``$ apt-get install execstack``
  - ``$ execstack -c <path>``

- AF_UNIX socket (e.g. for OpenSSH control-master) can't be set NONBLOCKING
  - Currently (as of 1803) bug, move your socket directory to root fs
  - ``$ ln -s /home/<name>/.ssh/ctrl ~/.ssh``
