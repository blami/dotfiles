"NOTE This is not really a plugin, it's just script to source additional files
"after packs are loaded.

"Load configuration files in conf/*.vim
for f in split(glob(g:confdir.'/conf/*.vim'), '\n')
    exec 'source' f
endfor

"Include other configuration
exec 'source' g:confdir.'/abbrev.vim'
exec 'source' g:confdir.'/keymap.vim'
exec 'source' g:confdir.'/autocmd.vim'
