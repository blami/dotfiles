" ~/.config/nvim/init.vim - Neovim configuration

" {{{ General
" Encodings and formats
if has('vim_starting')
    set encoding=utf-8
    scriptencoding utf-8
endif
set fileformats=unix,dos                                " <EOL> formats that will be tried

" File reading/handling
set modeline                                            " Process 'vim:' modelines in files
set exrc                                                " Per-project .vimrc loading
set secure                                              " No autocmd in per-project .vimrc
set hidden                                              " Hide buffers instead of closing
filetype plugin on
filetype indent on
set noautochdir                                         " Don't cd to file directory
set autoread                                            " Re-read file when changed outside

" Compatible mode options
set cpoptions=aABceFs_

" Error handling
set noerrorbells                                        " Disable error bells
set belloff=all
" }}}


" {{{ Behavior
" NOTE Settings here are very basic defaults and often overriden by ftplugin
" Indentation
set smarttab
set smartindent                                         " Smart indent (similar to cindent)
set autoindent                                          " Continue indentation automatically
set copyindent                                          " Copy indentation from previous line
set expandtab                                           " Indent using spaces instead of tab
set shiftwidth=4
set shiftround                                          " Use multiple of shiftwidth for indent
set softtabstop=4
set tabstop=4
set backspace=indent,eol,start                          " Backspace behavior
set nostartofline                                       " Keep cursor in column between lines
set nojoinspaces                                        " Don't insert 2 spaces after .!?

" Automatic formatting
"set formatoptions=troqni1j                              " See :help fo

" Word-wrapping and line breaks
set nowrap
set textwidth=79                                        " Default text-width at 79 columns
set linebreak                                           " Break long lines at 'breakat'
set breakat=\ \ ;:,!?

" Diff
set diffopt=filler,iwhite

" Folding
set foldenable
set foldmethod=marker                                   " Fold by markers
set foldlevel=100                                       " Don't fold automatically
set foldopen=block,hor,mark,percent,quickfix,tag        " Open fold on those actions
" }}}


" {{{ Clipboard
set clipboard=unnamedplus                               " Use system clipboard
" TODO Configure g:clipboard
" }}}


" {{{ Search and Replace
set ignorecase                                          " Ignore case in searches
set smartcase                                           " Keep case when searching *
set wrapscan                                            " Wrap around (begin->end, end->begin)
set incsearch                                           " Incremental search
set gdefault                                            " Add /g by default, invert by /g

set magic                                               " Turn on magic for regexes
" }}}


" {{{ Spell checking
let g:spelllangs=['en', 'cs']                           " Available spell languages (for cycling)
set nospell                                             " Globally disable spellcheck by default

" Custom word list(s)
let &spelllang=get(g:spelllangs, 0)
let &spellfile=$HOME."/.config/nvim/spell/".&g:spelllang.".utf8.add,,"
            \ .$HOME."/.config/nvim/spell/common.utf8.add"
" }}}


" {{{ User Interface
set laststatus=2                                        " Always show last status
set cmdheight=2                                         " Command line height 2 (better message display)
set showmode                                            " Show current MODE
set showcmd                                             " Show command
set shortmess+=cm
set ruler                                               " Show current line/column
set number                                              " Show line numbers
set numberwidth=4
set signcolumn=yes                                      " Show sign gutter column

" Buffers and Tabs
set splitbelow splitright                               " Open splits below or on right
set switchbuf+=useopen,usetab                           " Re-use open window/tab

" Scrolling
set scrolloff=2                                         " Show at least 2 lines above/below
set sidescrolloff=8                                     " Show at least 8 columns left/right
set scrolljump=5                                        " Jump by 5 lines when cursor leaves screen

" Status
set statusline=
" Status left side
set statusline+=%92*%2.2n%*
set statusline+=\ %95*%{status#ShowMode()}%*            " Mode
set statusline+=\ %t%m%94*%r%*
set statusline+=\ %92*[%{&ft!=''?&ft:'off'}]%*          " Filetype
set statusline+=\ %<%{&ff}%{&fenc!=''?','.&fenc:''}     " File format and encoding
set statusline+=\ %96*%{status#StatusPage()}%*       " Buffer specific status information
" Status right side
set statusline+=%=
set statusline+=%{&spell!=0?strpart(&spelllang,0,2):''}
set statusline+=\ %97*%{status#ShowPaste()}%*           " Paste status
set statusline+=\ ch=%b,0x%B                            " Character code
set statusline+=\ %93*%{matchstr(&fo,'t')!=''?'>'.&tw.'\ ':''}%c,%l/%LL\ %P%* " Position [>tw] (col,line/lines) all%

" Tabs
set showtabline=2

" Title
if has('title')
    set title
    set titlestring=NVIM:\ [%{hostname()}]\ %t\ %m%r    " NVIM: [hostname] filename [+-=][RO]
    set titleold=NVIM
endif

" Terminal
" NOTE Neovim always sets ttyfast
set timeout timeoutlen=750                              " Key mapping sequence timeout (ms)
set ttimeout ttimeoutlen=50                             " Key code sequence timeout (ms)
set lazyredraw                                          " Don't redraw on registers and macros

" Mouse
if has('mouse')
    set mousehide                                       " Hide mouse when typing (GUI)
    set mouse=nv                                        " Disable mouse in command-line mode
endif

" GUI
if has('gui_running')
    behave xterm
    " Fonts
    if has('unix')
        set guifont=Go\ Mono\ NF\ 11
    elseif has('win32')
        set guifont=Go\ Mono\ NF:h10.5:cEASTEUROPE
    endif
endif
" }}}


" {{{ Colors and Highlighting
colors blami
set background=dark                                     " Set dark background
syntax on
set termguicolors
set synmaxcol=200                                       " Highlight only first 200 columns
set colorcolumn=80,120                                  " Highlight wrap columns
set nocursorline                                        " Don't highlight line with cursor
set hlsearch                                            " Highlight search matches

" Bracket matching
set matchpairs=(:),{:},[:],<:>                          " Show matching pairs of brackets
set noshowmatch                                         " Don't skip to matching bracket
set matchtime=1                                         " Delay for showmatch
set cpoptions-=m                                        " Don't showmatch on copypaste

" Non-printable characters
set list                                                " Show non-printable chars
set listchars=tab:__,trail:.,extends:$,precedes:^       " How to show non-printable chars
" }}}


" {{{ Files and Directories
let s:confdir=split(&rtp[0], ',')[0]                    " Neovim config dir (init.vim)

" Command history
set history=4000

" Shared session data (former .viminfo)
set shada='500,<50,@100,h                               " See :help shada

" Backup and swap files
set nobackup                                            " Override current file (don't rename)
set swapfile                                            " Write swap and undo file
set updatetime=600                                      " Save swap file if no activity for 1s
set undofile
set undolevels=1000

" Filetype plugin
filetype plugin indent on                               " Enable filetype detection

" OS-specific paths and tools
if has('win32')
    set shell=bash.exe
endif
" }}}


" {{{ Includes
source $HOME/.config/nvim/plug.vim
source $HOME/.config/nvim/keymap.vim
source $HOME/.config/nvim/abbrev.vim

" Register global autocmds
source $HOME/.config/nvim/autocmd.vim
" }}}


" vim:set fo-=t:
