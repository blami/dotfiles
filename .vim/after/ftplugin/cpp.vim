"File:          cpp.vim
"Language:      C++

"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

"NOTE: See c.vim for common parts e.g. formatting, etc.
"DO NOT run lines below for C files
if (&ft != 'cpp') | finish | endif

"Project, see lua/blami/proj.lua
let b:projdir_detect=[
    \ '.clangd',
    \ '.clang-tidy',
    \ '.clang-format',
    \ 'compile_commands.json',
    \ 'compile_flags.txt',
    \ 'configure.ac'
    \]

"File Matching
setl suffixesadd=.cpp,.cxx,.c++,.h,.hpp,.hxx,.h++

"Keybindings
