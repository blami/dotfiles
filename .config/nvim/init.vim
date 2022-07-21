"Neovim init file

"{{{ General
set encoding=utf-8                          "use UTF-8 internally and for RPC
set cpoptions=aABceFs_                      "compatible mode options

"Command history
set history=8000

"Undo
set undofile                                "enable persistent undo
set undolevels=1000

"Load custom Lua library
lua blami=require('blami')
"}}}


"{{{ Variables
"TODO: Review this... does XDG work on Windows too?
"TODO: Is using stdpath() sane on WSL system?
let g:confdir=stdpath('config')             "config (init.vim) directory
let g:localdir=stdpath('data')              "local data directory
let g:sitedir=stdpath('data') . '/site'     "local site directory
let g:statedir=stdpath('state')             "local state directory
"}}}


"{{{ Files and Directories
"Directories
for d in ['backup', 'site/spell', 'swap', 'undo']
    call mkdir(g:localdir . '/' . d, 'p')
endfor
let &dir=g:localdir . '/swap'               "keep swap files in .local/
let &backupdir=g:localdir . '/backup'       "keep backups in .local/

"Loading Files
set modeline                                "process 'vim:' modeline in files
set exrc secure                             "load safe parts of per-project .exrc/.vimrc
set hidden                                  "hide buffers instead of closing
set autoread                                "re-read files when changed outside
set switchbuf+=useopen,usetab               "re-use open window/tab for switching buffers

"File Encoding
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8
"set bomb                                   "prepend file with BOM if needed
"set binary                                 "edit file as binary
set fileformats=unix,dos,mac                "<EOL> formats to try

"Backup and Swap Files
set backupcopy=yes                          "make backup COPY and overwrite original file
set backupskip+=~/tmp/*
set swapfile                                "create swapfiles in g:localdir/swap
"}}}


"{{{ Editing
set nowrap
set textwidth=79                            "default text-width is 79 columns
set nojoinspaces                            "do NOT insert 2 spaces after .!?
set linebreak breakat=\ \	.;:,!?。…！？   "break long lines at these characters

"Indentation, TAB and BS behavior
set expandtab                               "indent using spaces by default
set shiftwidth=4 softtabstop=4 tabstop=4    "TAB key and indent are both 4 spaces
set smarttab smartindent                    "smart indentation TAB/BS behavior
set autoindent copyindent breakindent       "automatically indent new lines
set backspace=indent,eol,start

"Formatting
"TODO Sane defaults?
"set formatoptions=

"Scrolling
set scrolloff=2                             "show at least 2 lines above/below
set sidescroll=8                            "show at least 8 columns left/right
set scrolljump=5                            "jump by 5 lines when cursor leaves screen
set nostartofline                           "keep cursor on same column when going up/down

"Folding
set foldenable foldmethod=marker            "fold by {{{ markers only
set foldlevel=100                           "don't fold automatically only on zC
set foldopen=block,hor,mark,percent,quickfix,tag
"}}}


"{{{ Search and Replace
set re=0                                    "use autoselection (NOTE =1 breaks Typescript)
set magic                                   "enable magic in regex e.g. ( matches \( groups... 
set ignorecase smartcase                    "ignore case on search/replace unless uppercase char used
set wrapscan                                "wrap around search/replace
set incsearch                               "incremental search (search as you type)
set gdefault                                "invert regex /g
"NOTE Causes issues with plugins/autoload scripts
"set inccommand=nosplit                     "visual feedback when substituting with :s
"}}}


"{{{ Diff
set diffopt=vertical                        "open diff in vertical split
set diffopt+=filler,iwhite                  "show filler lines, ignore spaces
set diffopt+=internal,algorithm:histogram   "use internal diff library, same algo as git
set diffopt+=indent-heuristic               "use indentation heuristics
"}}}


"{{{ User Interface
"Colors and Theme(s)
set termguicolors                           "GUI color depth in tty
set background=dark                         "default to dark background
syntax on                                   "enable syntax coloring
colors blami
" Fonts
if has('win32')
    set guifont="Go Mono NF:h13"
elseif has('linux') || has('gui_gtk2')
    set guifont="Go Mono NF 13"
endif

"Beeps
set noerrorbells belloff=all                "no ^A beeps

"Command-line
set cmdheight=2                             "command line height (lingering echomsg)
set showmode showcmd                        "current -- MODE -- in command line; last command
set shortmess+=cm                           "no completion messages (match X of Y...); [+] instead of modified
set shortmess-=S                            "show search [X/Y] message
set nowildmenu                              "ain't wildmenu lover
"Command-line completion ignored patterns:
set wildignore+=*.o,*.obj,*.a,*.so,*.pyc,*.pyo,*.gem,*.exe,*.dll
set wildignore+=.DS_Store,.git,.gitkeep

"Gutter
set signcolumn=yes                          "show sign (warnings, git...) column
set number numberwidth=4                    "show line numbers

"Text
set colorcolumn=80,120                      "highlight columns 80,120 (ftplugin overrides)
set cursorline                              "highlight line with cursor (only using that in number column)
set hlsearch                                "highlight search matches
set list                                    "show non-printable characters by default (see autocmd.vim!)
set listchars=tab:⯈\ ,trail:·,eol:,extends:$,precedes:^
set matchpairs=(:),{:},[:],「:」,【:】      "match pair characters (highlight match)
set matchtime=1
set noshowmatch                             "don't briefly skip to matching bracket
"set cpoptions-=m                           "don't showmatch on paste
set emoji                                   "enable emoji

"Splits
set splitbelow splitright                   "open splits below or on right

"Status-line
set laststatus=2                            "always show statusline
set noruler                                 "no need for ruler it's in statusline

let g:curwin=win_getid()                    "current window unique id initial state
set statusline=
"Left side
set statusline+=%2.2n                       "buffer number
set statusline+=\ %1*%{g:curwin==win_getid()?blami#statusline#Mode():''}%*
set statusline+=%{g:curwin==win_getid()?'\ ':''}
set statusline+=%t%m%r                      "file name[modified][read-only]
set statusline+=\ %2*[%{&ft!=''?&ft:'-'}]%*
set statusline+=%{winwidth(0)>80?'\ '.&ff.(&fenc!=''?','.&fenc.'\ ':''):''}
set statusline+=%2*%{winwidth(0)>80&&g:curwin==win_getid()?blami#statusline#Page():''}%*
"Right side
set statusline+=%=
set statusline+=%{&spell!=0?strpart(&spelllang,0,2).'\ ':''}
set statusline+=%2*%{blami#statusline#LEDs()}%*
set statusline+=%{blami#statusline#LEDs()!=''?'\ ':''}
set statusline+=%b,0x%B                     "character code dec, hex
set statusline+=\ %2*%{matchstr(&fo,'c')!=''?'#':''}
set statusline+=%{matchstr(&fo,'t')!=''?'>':''}
set statusline+=%{matchstr(&fo,'[tc]')!=''?&tw:''}
set statusline+=%{matchstr(&fo,'[tc]')!=''?'\ ':''}
set statusline+=%c,%l/%LL%*\ %P             "ruler
"NOTE: This is used by blami#statusline#Refresh() in case of non-ft windows
let g:statusline=&statusline

"Tab-line
set showtabline=1                           "show tabline only when more tabs are open
"}}}


"{{{ Clipboard
"Use ~/bin/clip multi-OS wrapper
set clipboard+=unnamedplus
let g:clipboardTODO={
    \ 'name': 'clip',
    \ 'copy':   {'+': ['clip', '-c'], '*': ['clip', '-c'], },
    \ 'paste':  {'+': ['clip', '-p'], '*': ['clip', '-p'], },
    \ 'cache_enabled': 1,
    \}
"}}}


"{{{ Completion
set completeopt=menu,menuone,noselect       "show menu (even for one option), do not select match automatically
"}}}


"{{{ Diagnostics
"
"Gutter Signs
sign define DiagnosticSignError     text= texthl=DiagnosticSignError
sign define DiagnosticSignWarn      text= texthl=DiagnosticSignWarn
sign define DiagnosticSignHint      text= texthl=DiagnosticSignHint
sign define DiagnosticSignInfo      text= texthl=DiagnosticSignInfo

sign define Bookmark                text=

"NOTE: See colors/blami.vim for highlights
"}}}


"{{{ Spell-checking
"NOTE Dictionary downloads/updates are handled by Ansible playbook and
"spellfile.vim is disabled because of that.
let loaded_spellfile_plugin=1

let g:spelllangs=['en', 'cs']
set nospell                                 "by default do not spellcheck
let &spelllang=get(g:spelllangs, 0)
let &spellfile=
    \ g:confdir.'/spell/'.&g:spelllang.'.utf8.add,'
    \ .g:confdir.'/spell/common.utf8.add'
"set complete+=kspell                       "show spell completions
"}}}


"{{{ OS specific
"Window title
"NVIM: [hostname] filename [+-=][RO]
set title titlestring=NVIM:\ [%{hostname()}]\ %t\ %m%r
set titleold=NVIM

"TTY
set ttyfast
set lazyredraw
set timeout timeoutlen=750                  "key mapping sequence timeout (ms)
set ttimeout ttimeoutlen=50                 "key code sequence timeout (ms)

"MS Windows 32/64bit
if has('win32')
    set shell=bash.exe                      "use WSL bash.exe on Windows
endif
"}}}


"{{{ Printing
"Keeping this one around for highschool days nostalgia
set printoptions=paper:a4,duplex:on
"}}}


"{{{ Includes and Plugins
"Filetype plugins
filetype plugin on
filetype indent on

"Disable scripting language providers
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0

"Load plugin _pre configuration before setting up packs; this is useful for
"setting globals. NOTE: See after/plugin/source.vim for the non-_pre configs.
for f in split(glob(g:confdir.'/conf/*_pre.vim'), '\n')
    exec 'source' f
endfor

"Setup packs
exec 'source' g:confdir.'/packs.vim'

"NOTE: All other configs are sourced from after/plugin/source.vim to have
"plugins/packs loaded. This is so I can rely on things like g: variables being
"already set by them in e.g. keymap.vim.
"}}}
