"Key and mouse mappings

let mapleader=','
let g:mapleader=','
let maplocalleader='-'                                  "Leader for ftplugins


"MODE                               MAPPING                 COMMAND
"------------------------------------------------------------------
"{{{Toggles
"Toggle fo flags t (text wrapping) and c (comment wrapping) a textwidth
"TODO redo this so it follows original settings
nnoremap    <silent><expr>          <leader>tw              match(&fo,'[tc]')>-1?':setl fo-=c fo-=t<CR>':':setl fo+=tc<CR>'
nnoremap    <silent><expr>          <leader>twc             match(&fo,'c')>-1?':setl fo-=c<CR>':':setl fo+=c<CR>'
nnoremap    <silent><expr>          <leader>twt             match(&fo,'t')>-1?':setl fo-=t<CR>':':setl fo+=t<CR>'
nnoremap    <silent>                <leader>w               :setl invwrap<CR>

nnoremap    <silent>                <leader>p               :setl invpaste<CR>
nnoremap    <silent>                <leader>pp              :echoerr 'toggle paste mode, columns and list'<CR>
nnoremap    <silent>                <leader>l               :setl invlist<CR>
nnoremap    <silent>                <leader>s               :setl invspell<CR>
nnoremap    <silent>                <leader>n               :call blami#toggle#Number()<CR>
"Toggle per-buffer autofmt that controls LSP document formatting
nnoremap    <silent><expr>          <leader>f               get(b:,'autofmt',0)==0?':let b:autofmt=1<CR>':':let b:autofmt=0<CR>'
"Toggle per-buffer status pages
map         <silent>                [p                      :call blami#statusline#PageToggle('-')<CR>
map         <silent>                ]p                      :call blami#statusline#PageToggle('+')<CR>

noremap     <silent>                <leader>bg              :let &bg=(&bg=='dark'?'light':'dark')<CR>

"Folds
nnoremap    <silent><expr>          <leader>F               &foldlevel==100?':setl foldlevel=0<CR>':':setl foldlevel=100<CR>'

"Buffers and tabs
map         <silent>                [b                      :bprevious<CR>
map         <silent>                ]b                      :bnext<CR>
map         <silent>                <C-t>                   :tabnew<CR>
map         <silent>                [t                      :tabprevious<CR>
map         <silent>                ]t                      :tabnext<CR>

"Quickfix (error) and location list
noremap     <silent>                <leader>ql              :call blami#toggle#List('c')<CR>
noremap     <silent>                <leader>ll              :call blami#toggle#List('l')<CR>
map         <silent>                [q                      :cprevious<CR>
map         <silent>                ]q                      :cnext<CR>
map         <silent>                [l                      :lprevious<CR>
map         <silent>                ]l                      :lnext<CR>

"Search
nnoremap    <silent>                \                       :noh<CR>

"Files and directories
"Change directory to current buffer directory
if exists('g:loaded_nerd_tree')
noremap     <silent>                `                       :NERDTreeToggleVCS<CR>
endif
nnoremap    <silent>                <leader>cdb             :cd %:p:h<CR>
"}}}


"{{{ Completion and snippets
"Completion
if exists('g:loaded_compe')
inoremap    <silent><expr>          <C-Space>               compe#complete()
inoremap    <silent><expr>          <CR>                    compe#confirm('<CR>')
endif

"Snippets
"TODO
"}}}


"{{{ Editing
"Paste last yank
nnoremap                            pp                      "0p

"Uppercase/lowercase inner word (`z)
nnoremap                            <C-u>                   mzgUiw`z
inoremap                            <C-u>                   <ESC>mzgUiw`za
nnoremap                            <C-l>                   mzguiw`z
inoremap                            <C-l>                   <ESC>mzguiw`za

"Underline current line (`z)
nnoremap                            <leader>u-              mzyypv$r-o<ESC>`z
nnoremap                            <leader>u=              mzyypv$r=o<ESC>`z
nnoremap                            <leader>u~              mzyypv$r~o<ESC>`z

"Sorting (normal/reverse/unique)
vnoremap                            <leader>az              :sort i<CR>
vnoremap                            <leader>za              :sort! i<CR>
vnoremap                            <leader>azu             :sort iu<CR>
vnoremap                            <leader>zau             :sort! iu<CR>

"Clone paragraph under cursor
nnoremap                            <leader>cp              yap<S-}>p

"Blockquote (>) or comment out (#, or // for commentstring) visual selection
vnoremap                            <leader>>               :s/^/><CR>:nohl<CR>
vnoremap                            <leader>#               :s/^/#<CR>:nohl<CR>
vnoremap                            <leader>//              :s/^/\=printf(&commentstring, submatch(0))<CR>:nohl<CR>

"Add word to current language/common spellfile
nnoremap                            <leader>sa              zg
nnoremap                            <leader>sac             3zg
"}}}


"{{{ Commands
"Handy when editing ro files, use sudo
cmap                                w#                      w !sudo -S tee % >/dev/null
"}}}
