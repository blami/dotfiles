# There's no place like `~`

This is set of my personal dotfiles, scripts, themes, playbooks and other
belongings I carry around everywhere where I get account. This repo isn't meant
for clone and use; it's more like garage where you might find some interesting
parts for your own thing.

## Layout
My usual `~` directory looks like this (including directories that aren't part
of this repository).

 `bin/`    - custom scripts, first item in my `$PATH`
- `blog/`   - sources of my [blog](https://www.blami.net)
- `desk/`   - desktop directory
- `docs/`   - documents
  - `papers -> drive/papers` - interesting papers
- `downl/`  - downloads
  - `archive/` - archived downloads
- `drive/`  - cloud drive directory (synced by daemon)
- `local -> .local/` - home variant of `/usr/local`
  - `go/`   - my local `$GOPATH`, only for tools
  - `share/`- home variant of `/usr/local/share` (fonts, icons, etc.)
- `media/`  - multimedia files like music or videos I momentarily need
- `ops/`    - ops related stuff
  - `playbooks/` - Ansible playbooks to setup my workstation/VM/WSL, etc.
- `pics -> drive/pics` - pictures like my avatar or favorite memes
- `pub/`
- `public_html/` - contents of host/~blami if host runs webserver
- `sandbox/` - [sandbox]() directory for various experiments
- `tmpl/`   - all sorts of [templates]() of licenses, Makefiles, etc.
- `ws/`     - [workspace]() where most of my work (and leisure) lives
- `.config` - XDG\_CONFIG directory with all configs
- `.profile.d` - snippets sourced by Zsh on start to setup env vars, etc.
- `.vim`    - Vim configuration files
- `.zsh[_local]/` - various custom zsh commands, widgets and prompts
- `.zsh*` - zsh dotfiles

## Tools
My shell combo of choice is `Zsh` and `tmux`. I edit using `Vim` on any
platform where it is available. I also use `Total Commander` alot on Windows.
