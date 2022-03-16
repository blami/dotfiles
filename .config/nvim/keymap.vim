"keymap.vim - key and mouse mappings

"Mouse
set mouse=a                                 "enable mouse


let mapleader=','
let g:mapleader=','                         "leader for custom commands
let maplocalleader='-'                      "leader for ftplugins

"MODE                       MAPPING         COMMAND
"------------------------------------------------------------------------------
"{{{Toggles
"Toggle fo flags t (text wrapping) and c (comment wrapping) a textwidth
"TODO redo this so it follows original settings
nnoremap    <silent><expr>  <leader>tw      match(&fo,'[tc]')>-1?':setl fo-=c fo-=t<CR>':':setl fo+=tc<CR>'
nnoremap    <silent><expr>  <leader>twc     match(&fo,'c')>-1?':setl fo-=c<CR>':':setl fo+=c<CR>'
nnoremap    <silent><expr>  <leader>twt     match(&fo,'t')>-1?':setl fo-=t<CR>':':setl fo+=t<CR>'
nnoremap    <silent>        <leader>w       :setl invwrap<CR>

nnoremap    <silent>        <leader>p       :setl invpaste<CR>
nnoremap    <silent>        <leader>pp      :echoerr 'toggle paste mode, columns and list'<CR>
nnoremap    <silent>        <leader>l       :setl invlist<CR>
nnoremap    <silent>        <leader>s       :setl invspell<CR>
nnoremap    <silent>        <leader>n       :call blami#toggle#Number()<CR>
"Toggle per-buffer autofmt that controls LSP document formatting
nnoremap    <silent><expr>  <leader>f       get(b:,'autofmt',0)==0?':let b:autofmt=1<CR>':':let b:autofmt=0<CR>'
"Toggle per-buffer status pages
map         <silent>        [p              :call blami#statusline#PageToggle('-')<CR>
map         <silent>        ]p              :call blami#statusline#PageToggle('+')<CR>

noremap     <silent>        <leader>bg      :let &bg=(&bg=='dark'?'light':'dark')<CR>

"Folds
nnoremap    <silent><expr>  <leader>F       &foldlevel==100?':setl foldlevel=0<CR>':':setl foldlevel=100<CR>'

"Buffers and Tabs
map         <silent>        [b              :bprevious<CR>
map         <silent>        ]b              :bnext<CR>
map         <silent>        tt              :tabnew<CR>
map         <silent>        [t              :tabprevious<CR>
map         <silent>        ]t              :tabnext<CR>

"Quickfix (error) and location list
noremap     <silent>        <leader>ql      :call blami#toggle#List('c')<CR>
noremap     <silent>        <leader>ll      :call blami#toggle#List('l')<CR>
map         <silent>        [q              :cprevious<CR>
map         <silent>        ]q              :cnext<CR>
map         <silent>        [l              :lprevious<CR>
map         <silent>        ]l              :lnext<CR>

"Search
nnoremap    <silent>        \               :noh<CR>
noremap                     <F3>            /
inoremap                    <F3>            <Esc>/

"Files and directories
nnoremap                    <leader>cd      :cd %:p:h<CR>
nnoremap    <silent>        <leader>e       :e .<CR>
"}}}


"{{{ Editing
"Paste last yank
nnoremap                    pp              "0p

"Uppercase/lowercase inner word (`z)
nnoremap                    <C-Up>          mzgUiw`z
inoremap                    <C-Up>          <CMD>mzgUiw`z
nnoremap                    <C-Down>        mzguiw`z
inoremap                    <C-Down>        <CMD>mzguiw`z

"Underline current line (`z)
nnoremap                    <leader>u-      mzyypv$r-o<Esc>`z
nnoremap                    <leader>u=      mzyypv$r=o<Esc>`z
nnoremap                    <leader>u~      mzyypv$r~o<Esc>`z

"Sorting (normal/reverse/unique)
vnoremap                    <leader>az      :sort i<CR>
vnoremap                    <leader>za      :sort! i<CR>
vnoremap                    <leader>azu     :sort iu<CR>
vnoremap                    <leader>zau     :sort! iu<CR>

"Clone paragraph under cursor
nnoremap                    <leader>cp      yap<S-}>p

"Blockquote (>) or comment out (#, or // for commentstring) visual selection
vnoremap                    <leader>>       :s/^/><CR>:nohl<CR>
vnoremap                    <leader>#       :s/^/#<CR>:nohl<CR>
vnoremap                    <leader>//      :s/^/\=printf(&commentstring, submatch(0))<CR>:nohl<CR>
"}}}


"{{{ Selection
"TODO Shift+ visual selection (take from windows config?)
"}}}


"{{{ Completion
inoremap                    <C-Space>       <C-x><C-o>
"inoremap                    <C-space>s      <CMD>:lua vim.lsp.buf.signature_help()<CR>
"inoremap                    <C-s>h          <CMD>:lua vim.lsp.buf.hover()<CR>
"}}}


"{{{ Spellcheck
"Add word to current language/common spellfile
nnoremap                    <leader>sa      zg
nnoremap                    <leader>sac     3zg
"}}}


"{{{ External Commands and Terminal
"External Commands
noremap     <silent>        <F7>            :make<CR>
inoremap    <silent>        <F7>            <Esc>:make<CR>
"noremap     <silent>        <F8>            :echom TODO run debugger in term://

"Terminal
noremap     <silent>        <F12>           :split term://$SHELL<CR>
inoremap    <silent>        <F12>           <Esc>:split term://$SHELL<CR>
"}}}


"{{{ Help
noremap                     <F1>            :help 
inoremap                    <F1>            <Esc>:help 
"}}}


"{{{ Commands
"Typo and convenience aliases
cmap                        W               w
cmap                        Q               q
"Handy when editing ro files, use sudo
cmap                        w#              w !sudo -S tee % >/dev/null
"Always use lgrep
cnoreabbrev                 grep            lgrep
"}}}



