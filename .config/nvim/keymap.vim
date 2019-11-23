" ~/.config/nvim/keymap: Neovim keyboard mappings

" Leader key to `,'
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ",,"

" NOTE if needed my mappings use marks y,z and Y,Z.
" Mode                  Mapping                 Command
" -----------------------------------------------------------------------------

" {{{ Toggles
" NOTE All toggles are local to buffer
nnoremap <silent>       <leader>n               :call util#ToggleNumber()<CR>
nnoremap <silent>       <leader>nn              :setl nonumber norelativenumber<CR>
nnoremap <silent>       <leader>p               :setl invpaste<CR>
nnoremap <silent>       <leader>l               :setl invlist<CR>
" Toggle spellcheck and spellcheck language
nnoremap <silent>       <leader>s               :setl invspell<CR>
nnoremap <silent>       <leader>sl              :call util#ToggleSpellLang()<CR>
" Toggle formatting options parameter t (textwidth)
nnoremap <silent><expr> <leader>tw              matchstr(&fo,'t') != 't' ? ':setl fo+=t<CR>' : ':setl fo-=t<CR>'
" Toggle buffer status in statusline
noremap  <silent>       <F4>                    :call bufstatus#TogglePage('+')<CR>
inoremap <silent>       <F4>                    <ESC>:call bufstatus#TogglePage('+')<CR>a
" Toggle between light and dark colors
noremap  <silent>       <leader>bg              :let &background = (&background=="dark" ? "light" : "dark")<CR>
" Toggle NERDTree
"noremap  <silent>       <F11>                   :NERDTreeToggle<CR>
"inoremap <silent>       <F11>                   <ESC>:NERDTreeToggle<CR>i
" }}}


" {{{ Editing
" Visual block mode (ctrl+v is bound to paste and ctrl+q doesn't work in tty)
nnoremap                <C-b>                   <C-v>
vnoremap                <leader>b               <ESC><C-v>
" Backspace deletes selection
vnoremap                <BS>                    d
" Uppercase/lowercase inner word (`z)
nnoremap                <C-u>                   mzgUiw`z
inoremap                <C-u>                   <ESC>mzgUiw`za
nnoremap                <C-l>                   mzguiw`z
inoremap                <C-l>                   <ESC>mzguiw`za
" Underline current line (`z)
nnoremap                <leader>u-              mzyypv$r-o<ESC>`z
nnoremap                <leader>u=              mzyypv$r=o<ESC>`z
nnoremap                <leader>u~              mzyypv$r~o<ESC>`z
" Sorting (normal/reverse/unique)
vnoremap                <leader>az              :sort i<CR>
vnoremap                <leader>za              :sort! i<CR>
vnoremap                <leader>azu             :sort iu<CR>
vnoremap                <leader>zau             :sort! iu<CR>
" }}}


" {{{ Completion
"inoremap <silent><expr> <C-space>               coc#refresh()
" }}}


" {{{ Spell checking
nnoremap                <leader>sa              zg
nnoremap                <leader>sac             3zg
" }}}

" {{{ Selection, copy & paste
noremap                 <C-a>                   gggH<C-o>G
inoremap                <C-a>                   <ESC>gg<C-o>gH<C-o>G
xnoremap                <C-a>                   <ESC>ggVG
cnoremap                <C-a>                   <ESC>gggH<C-o>G
" copy & paste
"vnoremap                <C-x>                   "+x
"vnoremap                <S-DEL>                 "+x
"vnoremap                <C-c>                   "+y
"vnoremap                <C-INS>                 "+y
"noremap                 <C-v>                   "+gP
"noremap                 <S-INS>                 "+gP
" command mapping
"cnoremap                <C-v>                   <C-r>+
"cnoremap                <S-INS>                 <C-r>+
" }}}


" {{{ Search and Replace
nnoremap                <F3>                    n
nnoremap <silent>       \                       :noh<CR>
" replace
"nnoremap                <C-r>                   :%s/
"inoremap                <C-r>                   <ESC>:%s/
" }}}


" {{{ Buffers and Tabs
" Buffer navigation
nnoremap <silent>       <                       :bp<CR>
nnoremap <silent>       >                       :bn<CR>
" Tab navigation
" }}}


" {{{ Files
cnoremap                w#                      w !sudo tee % >/dev/null
" Diff
"nnoremap                <leader>dif             :call keymap#DiffLocal()<CR>
" Directory navigation
nnoremap                <leader>cd              :lcd %:p:h<CR>:pwd<CR>
nnoremap                <leader>~               :lcd $HOME<CR>:pwd<CR>
" Common files
"nnoremap                <leader>todo            :vs $HOME/TODO.md<CR>
" Quicksave
if has("gui")
    noremap             <C-s>                   :w<CR>
    inoremap            <C-s>                   <ESC>:w<CR>i
    vnoremap            <C-s>                   <ESC>:w<CR>v
endif
nnoremap                <F2>                    :w<CR>
inoremap                <F2>                    <ESC>:w<CR>i
vnoremap                <F2>                    <ESC>:w<CR>v
nnoremap                <leader>w               :w<CR>
nnoremap                <leader>w!              :w!<CR>
nnoremap                <leader>w#              :w#<CR>
" Quick exit
nnoremap                <leader>x               :x<CR>
" }}}


" {{{ External programs
" Run `make'
nnoremap                <F9>                    :make<CR>
inoremap                <F9>                    <ESC>:make<CR>
" Make and run program
nnoremap                <F5>                    :call util#Run()<CR>
inoremap                <F5>                    <ESC>:call util#Run()<CR>
" Pastebin (in normal mode whole file)
nnoremap                <leader>pb              :call util#Gist()<CR>
vnoremap                <leader>pb              :call util#Gist()<CR>
" }}}


" {{{ Help and Documentation
noremap                 <F1>                    :help<SPACE>
inoremap                <F1>                    <ESC>:help<SPACE>
" }}}


" {{{ Others
" Leave Ex mode for good
nnoremap                Q                       <nop>
" }}}


" vim:set fo-=t:
