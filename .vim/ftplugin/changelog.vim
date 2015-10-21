" Language:     ChangeLog
" Maintainer:   Ondrej Balaz <blami@blami.net>

" Enable system ftplugin (don't let b_didftplugin=1)

" Setup changelog variables
let g:changelog_username="Ondrej Balaz <blami@blami.net>"

" Create new entry in ChangeLog
nmap ,, :NewChangelogEntry<CR>
