" Language: git commit file
" Maintainer: Ondrej Balaz
" Filenames: *.git/COMMIT_EDITMSG

"NOTE: This just adds highlight for '.' at the end of summary line

syn match   gitcommitBlank "\%1l\.$" contained containedin=gitcommitSummary,gitcommitOverflow
