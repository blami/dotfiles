" ~/.config/nvim/plugin.vim - Neovim plugins configuration

" {{{ Plugins
" Install plugins to .local/share/ as they are not configuration
call plug#begin("$HOME/.local/share/nvim/pack")

" UI
Plug 'scrooloose/nerdtree',             { 'on': 'NERDTreeToggle' }
Plug 'kien/ctrlp.vim'

" VCS
Plug 'mhinz/vim-signify'

" Autocompletion and linting
Plug 'neoclide/coc.nvim',               { 'branch': 'release' }

" Language support

call plug#end()
" }}}


" {{{ Plugin settings
" COC
" NOTE: See ~/.config/nvim/coc-settings.json
" ALE
let g:ale_completion_enabled = 0
" }}}


" vim:set fo-=t:
