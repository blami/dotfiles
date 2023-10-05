"File:          go.vim
"Compiler:      Go

"if exists("current_compiler")
"  finish
"endif
let current_compiler = "go"

let s:cpo_save = &cpo
set cpo&vim

"{{{ Make
"Use make if Makefile exists; otherwise use go build
if filereadable("makefile") || filereadable("Makefile")
    setl makeprg=make
else
    setl makeprg=go\ build
endif
"}}}


"{{{ Errors
"Ignore lines with # and panic: messages
setl errorformat=%-G#\ %.%#
setl errorformat+=%-G%.%#panic:\ %m

setl errorformat+=%Ecan\'t\ load\ package:\ %m
setl errorformat+=%A%\\%%(%[%^:]%\\+:\ %\\)%\\?%f:%l:%c:\ %m
setl errorformat+=%A%\\%%(%[%^:]%\\+:\ %\\)%\\?%f:%l:\ %m
setl errorformat+=%C%*\\s%m
setl errorformat+=%-G%.%#
"}}}

let &cpo = s:cpo_save
unlet s:cpo_save
