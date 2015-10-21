" Language:     Mail
" Maintainer:   Ondrej Balaz <blami@blami.net>

" Enable system ftplugin (don't let b_didftplugin=1)

" Disable modeline
setlocal nomodeline

" Wrap at 72 column, break lines with >
setlocal tw=72
setlocal fo+=tcql

" Enable spellcheck
setlocal spell
setlocal spelllang=en_us
