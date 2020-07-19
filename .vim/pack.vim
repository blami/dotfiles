"Packages

"call pack#begin(g:localdir)
"packreg('plugins', 'prabirshrestha/async.vim')
"packreg('plugins', 'prabirshrestha/asyncomplete.vim')
"packreg('plugins', 'prabirshrestha/vim-lsp')
"packreg('plugins', 'prabirshrestha/asyncomplete-lsp.vim')

"call pack#end()


"General
"call pack#Register("plugins", "prabirshrestha/async.vim")

"Language server
"call pack#Register("plugins", "prabirshrestha/asyncomplete.vim")
"call pack#Register("plugins", "prabirshrestha/vim-lsp")
"call pack#Register("plugins", "prabirshrestha/asyncomplete-lsp.vim")

"Language server and autocomplete configuration
"NOTE: per-language settings are configured in after/ftplugin/*
let g:lsp_diagnostics_enabled=1
let g:lsp_diagnostics_echo_cursor=1                     "show explanations in normal mode
let g:lsp_signs_enabled=1
let g:lsp_signs_error={'text': ''}
let g:lsp_signs_warning={'text': ''}
let g:lsp_signs_information={'text': ''}
let g:lsp_signs_hint={'text': ''}
"TODO make sure this is part of color theme and works properly with dark/light
hi LspErrorText         guifg=#f2241f
hi LspWarningText       guifg=#e18254
hi LspInformationText   guifg=#58b0d9
hi LspHintText          guifg=#cdcdcd
let g:lsp_highlights_enabled = 1                        "highlight signs
let g:lsp_fold_enabled=0                                "disable code folding

let g:asyncomplete_auto_popup = 0                       "No autopopup

