"NOTE: This is not really a plugin, it's just script to source additional files
"after packs are loaded.

"Load plugin post (non _pre) configuration after all packs are added to rtp and
"loaded.
let oldwildignore=&wildignore
set wildignore=*_pre.vim
for f in split(glob(g:confdir.'/conf/*.vim'), '\n')
    exec 'source' f
endfor
let &wildignore=oldwildignore

"Include other configuration
exec 'source' g:confdir.'/abbrev.vim'
exec 'source' g:confdir.'/keymap.vim'
exec 'source' g:confdir.'/autocmd.vim'
