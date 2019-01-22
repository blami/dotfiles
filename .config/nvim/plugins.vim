" ~/.config/nvim/plugin.vim - Neovim plugins configuration

" {{{ Plugins
" Install plugins to .local/share/ as they are not configuration
call plug#begin("$HOME/.local/share/nvim/pack")

Plug 'scrooloose/nerdtree',             { 'on': 'NERDTreeToggle' }
Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim',            { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

call plug#end()
" }}}


" {{{ Plugin settings
" }}}


" vim:set fo-=t:
