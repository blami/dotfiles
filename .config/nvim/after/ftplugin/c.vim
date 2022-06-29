"Language: C
"Maintainer: Ondrej Balaz

"NOTE: Nvim (and Vim) treats all .h files as C++. For purely C projects it is
"recommended to have .exrc file in project root with:
"
"  augroup project
"    autocmd!
"    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
"  augroup END
"
"See: https://www.alexeyshmalko.com/2014/using-vim-as-c-cpp-ide/

"NOTE: Depends on compile_commands.json compilation database.
"See: https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html

"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

"TODO: Language Server

"Compiler
compiler clang

"Formatting
setl noexpandtab
setl textwidth=79
setl list

"File Matching
setl suffixesadd=.c,.h

"Keybindings
