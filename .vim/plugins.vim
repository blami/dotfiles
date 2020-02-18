"Plugins configuration

"Plugins
"Install plugins to .local/share/ as they are not configuration
"NOTE: using silent! to silence `git is missing` on Windows
silent! call plug#begin("$HOME/.local/share/vim/plugins")

" Completion and snippets


call plug#end()

"Settings
"Autocompletion & linting


"vim:set fo-=t:
