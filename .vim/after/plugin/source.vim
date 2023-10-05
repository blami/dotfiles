"File:          source.vim
"Description:   Source additional configs after other plugins are loaded
"               This is not really a plugin, it's just script to source
"               additional files after plugins are loaded.

"TODO: Do I still need this?
"Load plugin post (non _pre) configuration after all packs are added to rtp and
"loaded.
"let oldwildignore=&wildignore
"set wildignore=*_pre.vim
"for f in split(glob(g:confdir.'/conf/*.vim'), '\n')
"    exec 'source' f
"endfor
"let &wildignore=oldwildignore

"Include other configuration
exec 'source' g:vimdir . '/abbrev.vim'
exec 'source' g:vimdir . '/keymap.vim'
exec 'source' g:vimdir . '/autocmd.vim'
