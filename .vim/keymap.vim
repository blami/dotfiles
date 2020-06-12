"Keyboard mappings

"NOTE Language specific mappings are in after/ftplugin/*

"Leader key to `,'
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ",,"

"NOTE if needed my mappings use marks y,z and Y,Z.
"Mode                  Mapping                 Command
"-----------------------------------------------------------------------------
nnoremap <silent>       <leader>rc              :source $MYVIMRC<CR>

"Toggles
"NOTE All toggles are local to buffer
nnoremap <silent>       <leader>n               :call util#ToggleNumber()<CR>
nnoremap <silent>       <leader>nn              :setl nonumber norelativenumber<CR>
nnoremap                <leader>p               :setl invpaste<CR>
nnoremap <silent>       <leader>l               :setl invlist<CR>
"Toggle spellcheck and spellcheck language
nnoremap <silent>       <leader>s               :setl invspell<CR>
nnoremap <silent>       <leader>sl              :call util#ToggleSpellLang()<CR>
"Toggle formatting options parameters t(ext) and c(comment) textwidth
nnoremap <silent><expr> <leader>tw              matchstr(&fo,'t') != 't' ? ':setl fo+=t<CR>' : ':setl fo-=t<CR>'
nnoremap <silent><expr> <leader>cw              matchstr(&fo,'c') != 'c' ? ':setl fo+=c<CR>' : ':setl fo-=c<CR>'
"Toggle buffer status in statusline
noremap  <silent>       <F4>                    :call status#TogglePage('+')<CR>
inoremap <silent>       <F4>                    <ESC>:call status#TogglePage('+')<CR>a
"Toggle between light and dark colors
noremap  <silent>       <leader>bg              :let &background = (&background=="dark" ? "light" : "dark")<CR>
"Togle QuickFix
noremap  <silent>       <leader>e               :call util#ToggleList("Quickfix List", "c")<CR>
"Toggle NERDTree
"noremap  <silent>       <F11>                   :NERDTreeToggle<CR>
"inoremap <silent>       <F11>                   <ESC>:NERDTreeToggle<CR>i

"Editing
"Visual block mode (ctrl+v is bound and ctrl+q doesn't work in tty)
nnoremap                <C-b>                   <C-v>
vnoremap                <leader>b               <ESC><C-v>
"Backspace deletes selection
vnoremap                <BS>                    d
"Uppercase/lowercase inner word (`z)
nnoremap                <C-u>                   mzgUiw`z
inoremap                <C-u>                   <ESC>mzgUiw`za
nnoremap                <C-l>                   mzguiw`z
inoremap                <C-l>                   <ESC>mzguiw`za
"Underline current line (`z)
nnoremap                <leader>u-              mzyypv$r-o<ESC>`z
nnoremap                <leader>u=              mzyypv$r=o<ESC>`z
nnoremap                <leader>u~              mzyypv$r~o<ESC>`z
"Sorting (normal/reverse/unique)
vnoremap                <leader>az              :sort i<CR>
vnoremap                <leader>za              :sort! i<CR>
vnoremap                <leader>azu             :sort iu<CR>
vnoremap                <leader>zau             :sort! iu<CR>
"Clone paragraph under cursor
nnoremap                <leader>cp              yap<S-}>p

"Spell-checking
nnoremap                <leader>sa              zg
nnoremap                <leader>sac             3zg

"Selection, copy & paste
"Reselect last selected block
nnoremap                gV                      `[v`]
"Select all
"noremap                 <C-a>                   gggH<C-o>G
"inoremap                <C-a>                   <ESC>gg<C-o>gH<C-o>G
xnoremap                <C-a>                   <ESC>ggVG
cnoremap                <C-a>                   <ESC>gggH<C-o>G
"TODO Revisit below mappings for GUI
"copy & paste
"vnoremap                <C-x>                   "+x
"vnoremap                <S-DEL>                 "+x
"vnoremap                <C-c>                   "+y
"vnoremap                <C-INS>                 "+y
"noremap                 <C-v>                   "+gP
"noremap                 <S-INS>                 "+gP
"command mapping
"cnoremap                <C-v>                   <C-r>+
"cnoremap                <S-INS>                 <C-r>+

"Search and replace
nnoremap                <F3>                    n
nnoremap <silent>       \                       :noh<CR>
"nnoremap                <C-r>                   :%s/
"inoremap                <C-r>                   <ESC>:%s/

"Buffers and Tabs
"Buffer navigation
nnoremap <silent>       <                       :bp<CR>
nnoremap <silent>       >                       :bn<CR>
"Tabs
nnoremap <silent>       <C-t>                   :tabnew<CR>
nnoremap <silent>       <C-t>w                  :tabclose<CR>
"Make tab navigation similar to window navigation
nnoremap <silent>       <C-t><left>             :tabp<CR>
nnoremap <silent>       <C-t><right>            :tabn<CR>

"Files
cnoremap                w#                      w !sudo tee % >/dev/null
"Diff
"nnoremap                <leader>dif             :call keymap#DiffLocal()<CR>
"Directory navigation
nnoremap                <leader>cd              :lcd %:p:h<CR>:pwd<CR>
nnoremap                <leader>~               :lcd $HOME<CR>:pwd<CR>
"Common files
"nnoremap                <leader>todo            :vs $HOME/TODO.md<CR>
"Quicksave
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
"Quick exit
nnoremap                <leader>x               :x<CR>

"External programs
"Run `make'
nnoremap                <F9>                    :make<CR>
inoremap                <F9>                    <ESC>:make<CR>
"Pastebin (in normal mode whole file)
"nnoremap                <leader>gt              :call util#Gist()<CR>
"vnoremap                <leader>pb              :call util#Gist()<CR>

"Help and documentation
noremap                 <F1>                    :help<SPACE>
inoremap                <F1>                    <ESC>:help<SPACE>

"Leave Ex mode for good
nnoremap                Q                       <nop>


"vim:set fo-=t:
