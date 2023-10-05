"File:          graphql.vim
"Language:      GraphQL

"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

"Formatting
setl formatoptions-=t
setl iskeyword+=$,@-@
setl softtabstop=2
setl shiftwidth=2

"Comments
setl comments=:#
setl commentstring=#\ %s

"File Matching
setl suffixesadd=.graphql,.graphqls,.gql
