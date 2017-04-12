" ~/.vim/keymap: Vim keymap

" Toggles `;'
map <silent>            ;n              :set invnumber<RETURN>
map <silent>            ;p              :set invpaste<RETURN>a
map <silent>            ;l              :set invlist<RETURN>
map <silent>            ;w              :call AutowrapToggle()<RETURN>

" Buffer navigation
map <silent>            <<              :bp<RETURN>
map <silent>            >>              :bn<RETURN>

cmap                    w#              w !sudo tee % >/dev/null

" Search
map <silent>            \               :noh<RETURN>

" Function keys
map                     <F1>            :help<SPACE>
imap                    <F1>            <ESC>:help<SPACE>
map                     <F2>            :wa<RETURN>
imap                    <F2>            <ESC>:wa<RETURN>a
map                     <F9>            :make<RETURN>
imap                    <F9>            <ESC>:make<RETURN>a


" vim:set ft=vim fo-=t:
