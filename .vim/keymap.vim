"File:          keymap.vim
"Description:   Key and mouse mappings
"               Loads _after_ plugins (see vimrc).


let mapleader=','
let g:mapleader=','                         "leader for custom commands
let maplocalleader='-'                      "leader for ftplugins


"{{{ Toggles
"TODO: noremap?
"Text width
"TODO: what if tw=0?
map         <silent><expr>  <leader>tw      match(&fo,'[tc]')>-1?':setl fo-=c fo-=t<cr>':':setl fo+=tc<cr>'
map         <silent><expr>  <leader>twc     match(&fo,'c')>-1?':setl fo-=c<cr>':':setl fo+=c<cr>'
map         <silent><expr>  <leader>twt     match(&fo,'t')>-1?':setl fo-=t<cr>':':setl fo+=t<cr>'
"Wrap, list, spelling, line numbers
map         <silent>        <leader>w       :setl invwrap<cr>
map         <silent>        <leader>l       :setl invlist<cr>
map         <silent>        <leader>s       :setl invspell<cr>
map         <silent>        <leader>n       :if &number==1 && &relativenumber==0<bar>setl nonumber relativenumber<bar>elseif &number==0 && &relativenumber==0<bar>setl number<bar>else<bar>setl nonumber norelativenumber<bar>endif<cr>
"Autoformat on save
map         <silent>        <leader>f       :let b:autofmt=(get(b:,'autofmt',0)==0?1:0)<cr>
"Copy & paste
"map         <silent><expr>  <leader>c      TODO: hide number, sign, list and enable wrap
map         <silent>        <leader>p       :setl invpaste<cr>
"Dark/light background
map         <silent>        <leader>bg      :let &bg=(&bg=='dark'?'light':'dark')<cr>

"Search
noremap     <silent>        \               :nohls<cr>
map                         <f3>            /
map                         <s-f3>          :lgrep 
imap                        <f3>            <esc>/

"Folds
"TODO: Redo
nnoremap    <silent><expr>  <leader>F       &foldlevel==100?':setl foldlevel=0<CR>':':setl foldlevel=100<CR>'
"}}}

"Navigation using []
map         <silent>        [b              :bprevious<cr>
map         <silent>        ]b              :bnext<cr>
map         <silent>        [t              :tabprevious<cr>
map         <silent>        ]t              :tabnext<cr>
map         <silent>        [q              :cprev<cr>
map         <silent>        ]q              :cnext<cr>
map         <silent>        [l              :lprev<cr>
map         <silent>        ]l              :lnext<cr>
"TODO: [s]s to toggle status pages?

"}}}


"{{{ Editing
"inoremap                    ((              ()<left>
"Uppercase/lowercase inner word (`z)
nnoremap                    <c-up>          mzgUiw`z
inoremap                    <c-up>          <cmd>mzgUiw`z
nnoremap                    <c-down>        mzguiw`z
inoremap                    <c-down>        <cmd>mzguiw`z

"Underline current line (`z)
nnoremap                    <leader>u-      mzyypv$r-o<esc>`z
nnoremap                    <leader>u=      mzyypv$r=o<esc>`z
nnoremap                    <leader>u~      mzyypv$r~o<esc>`z

"Sorting (normal/reverse/unique)
vnoremap                    <leader>az      :sort i<cr>
vnoremap                    <leader>za      :sort! i<cr>
vnoremap                    <leader>azu     :sort iu<cr>
vnoremap                    <leader>zau     :sort! iu<cr>

"Clone paragraph under cursor
nnoremap                    <leader>cp      yap<s-}>p

"Blockquote (>) or comment out (#, or // for commentstring) visual selection
vnoremap                    <leader>>       :s/^/><cr>:nohl<cr>
vnoremap                    <leader>#       :s/^/#<cr>:nohl<cr>
vnoremap                    <leader>//      :s/^/\=printf(&commentstring, submatch(0))<cr>:nohl<cr>
"}}}


"{{{ Unmaps and Typos
nnoremap                    Q               <nop>
noremap                     K               <nop>
"map                         q:              :q
"}}}


"Help
map                         <f1>            :help 
imap                        <f1>            <esc>:help 


"Write using sudo
cmap                        w!!             w !sudo -S tee % >/dev/null


"{{{ Mouse
if has('mouse')
set mouse=a                                 "enable mouse


endif "has('mouse')
"}}}
