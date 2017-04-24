" ~/.vim/keymap: keyboard mappings

" Leader key to `,'
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ",,"

" NOTE if needed my mappings use marks y,z and Y,Z.

" {{{ Mappings
" Mode                  Mapping                 Command
" -----------------------------------------------------------------------------

" Toggles
" NOTE all toggles are local to buffer
nnoremap <silent>       <leader>n               :call util#ToggleNumber()<CR>
nnoremap <silent>       <leader>nn              :setl nonumber norelativenumber<CR>
nnoremap <silent>       <leader>p               :setl invpaste<CR>
nnoremap <silent>       <leader>l               :setl invlist<CR>
" toggle spellcheck and spellcheck language
nnoremap <silent>       <leader>s               :setl invspell<CR>
nnoremap <silent>       <leader>sl              :call util#ToggleSpellLang()<CR>
" toggle formatting options parameter t (textwidth)
nnoremap <silent><expr> <leader>tw              matchstr(&fo,'t') != 't' ? ':setl fo+=t<CR>' : ':setl fo-=t<CR>'


" Editing
" visual block mode (ctrl+v is bound to paste and ctrl+q doesn't work in tty)
nnoremap                <C-b>                   <C-v>
vnoremap                <leader>b               <ESC><C-v>
" backspace deletes selection
vnoremap                <BS>                    d
" uppercase/lowercase inner word (`z)
nnoremap                <C-u>                   mzgUiw`z
inoremap                <C-u>                   <ESC>mzgUiw`za
nnoremap                <C-l>                   mzguiw`z
inoremap                <C-l>                   <ESC>mzguiw`za
" underline current line (`z)
nnoremap                <leader>u-              mzyypv$r-o<ESC>`z
nnoremap                <leader>u=              mzyypv$r=o<ESC>`z
nnoremap                <leader>u~              mzyypv$r~o<ESC>`z
" sorting (normal/reverse/unique)
vnoremap                <leader>az              :sort i<CR>
vnoremap                <leader>za              :sort! i<CR>
vnoremap                <leader>azu             :sort iu<CR>
vnoremap                <leader>zau             :sort! iu<CR>


" Selection, copy & paste
" NOTE Windows-ish as Vim in tty/terminal catches ctrl+c anyway
" select all
noremap                 <C-a>                   gggH<C-o>G
inoremap                <C-a>                   <ESC>gg<C-o>gH<C-o>G
xnoremap                <C-a>                   <ESC>ggVG
cnoremap                <C-a>                   <ESC>gggH<C-o>G
" copy & paste
vnoremap                <C-x>                   "+x
vnoremap                <S-DEL>                 "+x
vnoremap                <C-c>                   "+y
vnoremap                <C-INS>                 "+y
noremap                 <C-v>                   "+gP
noremap                 <S-INS>                 "+gP
" command mapping
cnoremap                <C-v>                   <C-r>+
cnoremap                <S-INS>                 <C-r>+


" Search and replace
nnoremap                <F3>                    n
nnoremap <silent>       \                       :noh<CR>
" replace
nnoremap                <C-h>                   :%s/
inoremap                <C-h>                   <ESC>:%s/


" Buffers
" buffer navigation
nnoremap <silent>       <                       :bp<CR>
nnoremap <silent>       >                       :bn<CR>


" Files
cnoremap                w#                      w !sudo tee % >/dev/null
" diff
"nnoremap                <leader>dif             :call keymap#DiffLocal()<CR>
" directory navigation
nnoremap                <leader>cd              :lcd %:p:h<CR>:pwd<CR>
nnoremap                <leader>~               :lcd $HOME<CR>:pwd<CR>
" common files
"nnoremap                <leader>todo            :vs $HOME/TODO.md<CR>
" quick save
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
" quick exit
nnoremap                <leader>x               :x<CR>




" External programs
" run makeprg
nnoremap                <F9>                    :make<CR>
inoremap                <F9>                    <ESC>:make<CR>
" compile and run program
nnoremap                <F5>                    :echo "run"
inoremap                <F5>                    <ESC>:echo "run"
" pastebin (in normal mode whole file)
nnoremap                <leader>pb              :call keymap#Pastebin()<CR>
vnoremap                <leader>pb              :call keymap#Pastebin()<CR>


" Help and documentation
noremap                 <F1>                    :help<space>
inoremap                <F1>                    <ESC>:help<space>
" }}}


" vim:set ft=vim fo-=t:
