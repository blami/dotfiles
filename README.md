# There's no place like `~`

This is set of my personal dotfiles, scripts, themes, playbooks and other
belongings I carry around everywhere where I get account. This repo isn't meant
for clone and use; it's more like garage where you might find some interesting
parts for your own thing.

## Usage
This is mostly for me...
```
cd ~
umask 002
# Make sure there's (almost) nothing
git init .
git remote add -f -m main origin https://github.com/blami/dotfiles.git
git co main
mv .git .dfgit
```

## Layout
My usual `~` directory looks like this (including directories that aren't part
of this repository).

- `bin/`    - custom scripts, first item in my `$PATH`
- `blog/`   - sources of my [blog](https://www.blami.net)
- `desk/`   - desktop directory
- `docs/`   - documents
  - `til`   - clone of my [til](https://github.com/blami/til) repo
  - `papers -> drive/papers` - interesting papers
- `downl/`  - downloads
  - `arch/` - archived downloads
- `drive/`  - cloud drive directory (synced by daemon e.g. `rclone`)
- `local -> .local/` - home variant of `/usr/local`
  - `go/`   - my local `$GOPATH`, only for tools
  - `share/`- home variant of `/usr/local/share` (fonts, icons, etc.)
- `media/`  - multimedia files like music or videos I momentarily need
- `ops/`    - ops related stuff
  - `playbooks/` - Ansible playbooks to setup my workstation/VM/WSL, etc.
- `pics/`   - pictures
- `music/`  - music
- `videos/` - videos
- `pub/`
- `public_html/` - contents of `://host/~blami` if host runs webserver
- `sandbox/` - [sandbox][] directory for various experiments
- `tmpl/`   - all sorts of [templates][] of licenses, Makefiles, etc.
- `src/`     - [workspace][] where most of my work (and leisure) lives
- `.config` - XDG\_CONFIG directory with all configs
- `.profile.d` - snippets sourced by Zsh on start to setup env vars, etc.
- `.zsh[_local]/` - various custom zsh commands, widgets and prompts
- `.zsh*` - zsh dotfiles

## Software
- __Shell__ `zsh` (with `tmux` as multiplexer), Windows Terminal and `urxvt`
- __Editor__ `vim` (gVim x64 build on Windows)
- __Browser__ Google Chrome
- __File Managers__ Total Commander, 7Zip and IrfanViewer on Windows

TODO Perhaps declare software somewhere and use that for automated installation
(e.g. `ops/playbooks`).

## Hardware
I usually work at home on my custom-built rig. On the road I use Lenovo
Thinkpad X1C laptop or Microsoft Surface Go 2. All those machines run Windows
10 Pro with WSL1, some dual-boot to Ubuntu Linux. I have an Android phone.


## Workspace
TODO


## `_local` Files
Most of my configuration is made in way that it includes also `_local`
variants. These are plugin files that make sense only in certain environment
(e.g. at work). E.g. my `.gitconfig` includes `.gitconfig_local` if that
exists and that might override certain options. At work or in various other
places I use `_place` naming convention and then my own `bin/mklocallinks`
script to symlink `_place` to `_local`.

## Windows Setup
`powershell -ep Bypass bin\bootstrap.ps1`
