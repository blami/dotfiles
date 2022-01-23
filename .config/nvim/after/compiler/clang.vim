"Vim compiler file
"Compiler:              Clang
"Maintainer:            Ondrej Balaz
"Last Change:           2021-06-10

"if exists("current_compiler")
"  finish
"endif
let current_compiler = "clang"

let s:cpo_save = &cpo
set cpo&vim

"{{{ Make
"Use make if Makefile exists
if filereadable("makefile") || filereadable("Makefile")
    setl makeprg=make
endif
"}}}


"{{{ Errors
setl errorformat=\%f:%l:%c:\ %t%s:\ %m
"}}}

let &cpo = s:cpo_save
unlet s:cpo_save
