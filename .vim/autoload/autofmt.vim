"Auto-formatting helpers



"Disable autoformatting under certain conditions
func autofmt#Disable()
    let b:noautofmt = 1
endfunc


"LspDocumentFormatSync wrapper that only runs if b:noautofmt == 1. Allows to
"pass additional commands (e.g. import sorters, etc.)
func autofmt#Format(...)
    if get(b:, 'noautofmt', 0) | return | endif

    LspDocumentFormatSync
    "Execute other given commands (a bit meh but I control my ftplugins)
    for cmd in a:000
        execute(cmd)
    endfor
endfunc
