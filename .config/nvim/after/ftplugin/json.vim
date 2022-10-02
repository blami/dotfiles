"Language: JSON
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

"Formatting
setl expandtab shiftwidth=2 softtabstop=2 tabstop=4
setl formatoptions-=t

"File Matching
setl suffixesadd=.json

"Misc
if executable('jq')
    setl equalprg=jq\ -M\ "."

    "TODO: blami.autfomt.wrap()
    "TODO: write helper to run external command on buffer and populate qf with errors...
    autocmd BufWritePre <buffer> :%!jq '.' || echo <buffer>
endif
