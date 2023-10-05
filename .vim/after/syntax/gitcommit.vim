"File:          gitcommit.vim
"Language:      Git commit message
"Filenames:     *.git/COMMIT_EDITMSG

"NOTE: This just adds highlight for '.' at the end of summary line

syn match   gitcommitBlank "\%1l\.[[:space:]]*$" contained containedin=gitcommitSummary,gitcommitOverflow
