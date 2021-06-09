"NOTE This is not really a plugin, it's just script to source additional files
"after packs are loaded.

"Load packs configuration (to install packs see ~/.zsh/furnish/furnish_nvim)
for f in split(glob(g:confdir.'/packs/*.vim'), '\n')
    exec 'source' f
endfor

"Include other configuration
exec 'source' g:confdir.'/abbrev.vim'
exec 'source' g:confdir.'/keymap.vim'
exec 'source' g:confdir.'/autocmd.vim'
