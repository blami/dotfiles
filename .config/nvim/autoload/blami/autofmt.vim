"Function to set b:autofmt in ftplugin files

"Set b:autofmt=1 unless:
"- environment variable 'NOAUTOFMT' is set
"TODO check .noautofmt in project root?
func blami#autofmt#Enable() abort
    if !empty($NOAUTOFMT) | return | endif
    call setbufvar(bufname("%"), "autofmt", 1)
endfunc
