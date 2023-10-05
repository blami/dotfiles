"File:          keymap.vim
"Description:   Key and mouse mappings
"               Loads _after_ plugins (see after/plugin/source.vim).


let mapleader=','
let g:mapleader=','                         "leader for custom commands
let maplocalleader='-'                      "leader for ftplugins


"{{{ Toggles
"}}}


"{{{ Spell
"}}}


"{{{ Commandline
cmap                w#          w!sudo -S tee % >/dev/null
"}}}


"{{{ Mouse
if has('mouse')
set mouse=a                                 "enable mouse


endif
"}}}
