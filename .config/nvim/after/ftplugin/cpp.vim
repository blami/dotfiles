"Language: C++
"Maintainer: Ondrej Balaz

"NOTE: Depends on compile_commands.json compilation database.
"See: https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html

"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

"NOTE: See c.vim for common parts e.g. formatting, etc.
"DO NOT run lines below for C files
if (&ft != 'cpp') | finish | endif

"File Matching
setl suffixesadd=.cpp,.cxx,.c++,.h,.hpp,.hxx,.h++

"Keybindings
