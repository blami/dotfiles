# Neovim
This is my Neovim configuration.


## `conf/`
This directory contains configuration snippets for plugin packs. There are two
types of files treated differently:

* `<pack>_pre.vim` loaded before adding packs; this is useful for Vim-like
  globals configuration as globals have to be set before plugin is loaded.
* `<pack>.vim` loaded after packs are added to `rtp` and plugins loaded; this
  is useful for Neovim Lua-based configuration snippets.
