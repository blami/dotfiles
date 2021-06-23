"Neovim init

"{{{ General
"Compatible mode options
set cpoptions=aABceFs_

"Errors
set noerrorbells                                        "Disable ^A on error
set belloff=all

"Command history
set history=5000

"Builtins
"let loaded_netrw=0                                      "Do NOT disable netrw (plugins use it to download stuff)
"}}}


"{{{ Files and Directories
"Directories
let g:confdir=stdpath('config')                         "Config (init.vim) directory
let g:localdir=stdpath('data')                          "Local data directory

"Loading
set modeline                                            "Process 'vim:' modelines in files
set exrc                                                "Load per-project .vimrc
set secure                                              "No autocmd in per-project .vimrc
set hidden                                              "Hide buffers instead of closing
set autoread                                            "Re-read file when changed outside neovim
set switchbuf+=useopen,usetab                           "Re-use open window/tab for switching buffers

"Backup, swap files
set nobackup                                            "When saving overwrite current file (no rename)
set noswapfile

"Undo
set undofile                                            "Enable persistent undo
set undolevels=1000

"Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
"set bomb                                                "Prepend file with BOM if needed
"set binary                                              "Edit file as binary
set fileformats=unix,dos,mac                            "<EOL> formats to try
"}}}


"{{{ Editing
"NOTE Very basic defaults overriden by ftplugins
"Indentation
set expandtab                                           "Indent using spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4
"set shiftround                                          "Round indents to multiple of shiftwidth
set smarttab
set smartindent                                         "Smart indentation
set autoindent                                          "Continue indentation automatically
set copyindent                                          "Copy indentation from line above
set breakindent                                         "Indent breaked lines
set backspace=indent,eol,start
set nostartofline                                       "Keep cursor on same column when going up/down
set nojoinspaces                                        "Do NOT insert 2 spaces after .!?

"Formatting
"set formatoptions=

"Scrolling and wrapping
set scrolloff=2                                         "Show at least 2 lines above/below
set sidescroll=8                                        "Show at least 8 columns left/right
set scrolljump=5                                        "Jump by 5 lines when cursor leaves screen
set nowrap
set textwidth=79                                        "Default text-width is 79 columns
set breakat=\ \	.;:,!?
set linebreak                                           "Break long lines at 'breakat'

"Clipboard
"TODO remove TODO from g:clipboardTODO
set clipboard+=unnamedplus
"Use ~/bin/pb wrapper that detects WSL
let g:clipboardTODO={
    \ 'name': 'cb',
    \ 'copy': {
    \   '+': ['cb', '--copy', '-'],
    \   '*': ['cb', '--copy', '-'],
    \ },
    \ 'paste': {
    \   '+': ['cb', '--paste', '-'],
    \   '*': ['cb', '--paste', '-'],
    \ },
    \ 'cache_enabled': 1,
    \}

"Search and Replace
set re=1                                                "Use legacy regex engine (faster)
set magic                                               "Enable magic in regexes e.g. ( matches \( groups... 
set ignorecase                                          "Ignore case on searches
set smartcase                                           "Keep case when searching *
set wrapscan                                            "Wrap around searches (begin<->end)
set incsearch                                           "Incremental search (search as you type)
set gdefault                                            "Add /g by default, invert by adding /g
"NOTE Causes issues with plugins/autoload scripts...
"set inccommand=nosplit                                  "Visual feedback when substituting with :s

"Folding
set foldenable
set foldmethod=marker                                   "Fold by {{{ markers only
set foldlevel=100                                       "Don't fold automatically only on zC
set foldopen=block,hor,mark,percent,quickfix,tag        "Open fold on those actions

"Diff
set diffopt=filler,iwhite,vertical                      "Show filler lines, ignore spaces, vertical split
set diffopt+=internal,algorithm:histogram               "Use internal diff library, same algo as git
set diffopt+=indent-heuristic                           "Use indentation heuristics

"Spell checking
let g:spelllangs=['en', 'cs']
set nospell
let loaded_spellfile_plugin=1                           "Disable spellfile.vim dictionary downloads
                                                        "See autocmd.vim for SpellFileMissing
let &spelllang=get(g:spelllangs, 0)
let &spellfile=g:confdir.'/spell/'.&g:spelllang.'.utf8.add,'
    \ .g:confdir.'/spell/common.utf8.add'               "Custom spell files for added words (in my dotfiles)
set complete+=kspell

"Printing
set printoptions=paper:a4,duplex:on
"}}}


"{{{ Look and feel
"Command line
set cmdheight=2                                         "Command line height (lingering echomsg)
set showmode                                            "Show current -- MODE -- in command line
set showcmd                                             "Show command
set shortmess+=cm                                       "No completion messages (match X of Y...); [+] instead of modified
set shortmess-=S                                        "Show search [X/Y] message

"Signs and line numbers
set signcolumn=yes                                      "Show sign (warnings, git...) column
set number                                              "Show line numbers
set numberwidth=4

"Text
set colorcolumn=80,120                                  "Highlight columns 80,120 (ftplugin overrides)
set cursorline                                          "Highlight line with cursor (only using that to CursorLine)
"set cursorline                                          "Highlight line cursor is on
set hlsearch                                            "Highlight search matches
set list                                                "Show non-printable characters
set listchars=tab:⯈\ ,trail:·,eol:¬,extends:$,precedes:^
set matchpairs=(:),{:},[:]                              "Match pair characters (highlight match)
set matchtime=1
set noshowmatch                                         "Don't briefly skip to matching bracket
"set cpoptions-=m                                        "Don't showmatch on paste
set emoji                                               "Enable emoji

"Splits
set splitbelow splitright                               "Open splits below or on right

"Status line
let g:curwin=winnr()                                    "Current window number initial state
set laststatus=2                                        "Always show last status
set ruler                                               "Show current line/column in status
set statusline=
"Status line left side
set statusline+=%2.2n                                   "Buffer number
set statusline+=\ %1*%{g:curwin==winnr()?blami#statusline#Mode():''}%* "Mode (only active window)
set statusline+=%{g:curwin==winnr()?'\ ':''}            "(space)
set statusline+=%t%m%r                                  "Filename, modified, ro/rw
set statusline+=\ %2*[%{&ft!=''?&ft:'-'}]%*             "Filetype
set statusline+=%{winwidth(0)>80?'\ '.&ff.(&fenc!=''?','.&fenc.'\ ':''):''} "File format and encoding
set statusline+=%2*%{winwidth(0)>80&&g:curwin==winnr()?blami#statusline#Page():''}%* "Per-buffer status page (only active window)
"Status right side
set statusline+=%=
set statusline+=%{&spell!=0?strpart(&spelllang,0,2).'\ ':''} "Spell checker language
set statusline+=%2*%{blami#statusline#LEDs()}%*         "Various LEDs
set statusline+=%{blami#statusline#LEDs()!=''?'\ ':''}  "(space)
set statusline+=%b,0x%B                                 "Character code in dec,hex
set statusline+=\ %2*%{matchstr(&fo,'c')!=''?'#':''}    "Comment wrapping flag
set statusline+=%{matchstr(&fo,'t')!=''?'>':''}         "Text wrapping flag
set statusline+=%{matchstr(&fo,'[tc]')!=''?&tw:''}      "Text width if t or c in &fo
set statusline+=%{matchstr(&fo,'[tc]')!=''?'\ ':''}     "(space)"
set statusline+=%c,%l/%LL%*\ %P                         "Ruler
"NOTE This is used by blami#statusline#Refresh() in case of non-Filetyped windows
let g:statusline=&statusline

"Tab line
set showtabline=1                                       "Show tabline only when more tabs are open

"Wildmenu
set wildmenu
set wildmode=list:longest,list:full
"TODO revisit this
set wildignore+=*.o,*.obj,*.a,*.so,*.pyc,*.gem,*.exe,*.dll
set wildignore+=.DS_Store,*.jpg,*.png,*.gif,*.svg,*.psd,*.ai,*.ttf,*.otf,*.woff,*.woff2,*.eot
set wildignore+=.git,.gitkeep

"Colors and theme
set termguicolors                                       "GUI colors in terminal
set background=dark
syntax on
colors blami

"Window title
set title titlestring=NVIM:\ [%{hostname()}]\ %t\ %m%r  "NVIM: [hostname] filename [+-=][RO]
set titleold=NVIM
"}}}


"{{{ OS specific
"TTY
set ttyfast
set lazyredraw
set timeout timeoutlen=750                              "Key mapping sequence timeout (ms)
set ttimeout ttimeoutlen=50                             "Key code sequence timeout (ms)

"MS Windows 32/64bit
if has('win32')
    set shell=bash.exe                                  "Use WSL bash.exe on Win
endif
"}}}


"{{{ Includes and Plugins
"Filetype plugins
filetype plugin on
filetype indent on

"blami Lua module
lua blami=require('blami')

"NOTE All other configs are sourced from ~/after/plugin/source.vim to have plugins loaded
"}}}
