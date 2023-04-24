# There's no place like `~`

This is set of my personal dotfiles, scripts, themes, playbooks and other
belongings I carry around everywhere where I get account. This repo isn't meant
for clone and use; it's more like garage where you might find some interesting
parts for your own thing.

## `~` Layout
My usual `~` directory looks like this (including directories that aren't part
of this repository):

- `bin/`    - custom scripts, first item in my `$PATH`
- `blog/`   - sources of my [blog](https://www.blami.net)
- `desk/`   - desktop directory
- `docs/`   - documents
  - `papers -> drive/papers`- interesting papers
- `downl/`  - downloads
  - `arch/` - archived downloads
- `drive/`  - cloud drive directory (synced by daemon e.g. `rclone`)
- `local -> .local/`- home variant of `/usr/local`
  - `go/`   - local `$GOPATH`, only for tools
  - `node/` - local Node.js modules directory
  - `share/`- home variant of `/usr/local/share` (fonts, icons, etc.)
- `ops/`    - ops related stuff
  - `ansible/`- Ansible playbooks to setup my workstation/VM/WSL, etc.
  - `choco/`- local Chocolatey packages
  - `dockerfiles/`- general purpose Dockerfiles
  - `ubuntu/`- various Ubuntu related things (e.g. autoinstall)
- `mail/`   - maildir(s)
- `pics/`   - pictures
- `music/`  - music
- `videos/` - videos
- `pub/`    - public directory (accessible to other system users)
- `public_html/` - contents of `://host/~blami` if host runs webserver
- `sandbox/` - [sandbox][] directory for various experiments
- `tmpl/`   - all sorts of [templates][] of licenses, Makefiles, etc.
- `src/`    - [src][] where most of my work (and leisure) lives
- `.config` - XDG\_CONFIG directory with all configs
- `.profile.d` - snippets sourced by Zsh on start to setup env vars, etc.
- `.zsh[_local]/` - various custom zsh commands, widgets and prompts
- `.zsh*` - zsh dotfiles

## `_local` Files
Most of my configuration is made in way that it includes also `_local`
variants. These are plugin files that make sense only in certain environment
(e.g. at work). E.g. my `.gitconfig` includes `.gitconfig_local` if that
exists and that might override certain options. At work or in various other
places I use `_place` naming convention and then my own `bin/mklocallinks`
script to symlink `_place` to `_local`.
