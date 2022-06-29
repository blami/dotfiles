"Language: C++
"Maintainer: Ondrej Balaz

"NOTE: Depends on compile_commands.json compilation database.
"See: https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html

"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
"Do not run lines below for C files
if (&ft != 'cpp') | finish | endif

"TODO: Language Server

"Compiler
compiler clang

"Formatting
setl noexpandtab
setl textwidth=119
setl list

"File Matching
setl suffixesadd=.cpp,.cxx,.c++,.h,.hpp,.hxx,.h++

"Keybindings
