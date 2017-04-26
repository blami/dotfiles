" Language:     Vim help file
" Maintainer:   Ondrej Balaz <blami@blami.net>

" {{{ Editing
" Indentation
setlocal noexpandtab                                                            " use real Tabs

" Wrapping
if exists("+colorcolumn")
    set cc=+1                                                                   " highlight column next to tw
endif
" }}}

" {{{ Autocommands
" Open help in vertical split
autocmd! BufWinEnter <buffer>
            \ wincmd L"{{{"}}}
" }}}
