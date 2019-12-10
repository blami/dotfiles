" ~/.config/nvim/plugin.vim - Neovim plugins configuration

" {{{ Plugins
" Install plugins to .local/share/ as they are not configuration
" NOTE: using silent! to silence `git is missing` on Windows
silent! call plug#begin("$HOME/.local/share/nvim/pack")

" Autocompletion & lining
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'Shougo/neosnippet'

"Plug 'ctrlpvim/ctrlp.vim'

" Version control
"Plug 'mhinz/vim-signify'

" Language support
"Plug 'fatih/vim-go'

" Integrations
"Plug 'tpope/vim-fugitive'

call plug#end()
" }}}


" {{{ Plugin settings
" Autocompletion & linting

let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#snippets_directory = '~/.config/nvim/snippets'

" Version control
" NOTE Only show signs for git and Mercurial
"let g:signify_vcs_list = ['git', 'hg']


" }}}


" vim:set fo-=t:
