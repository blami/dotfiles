"Various utility function, mostly used in other scripts

"Get list of all windows, optionally filter out windows matching certain
"criteria:
"r - filter out all relative (floating) windows
func blami#util#Winnrs(filter) abort
    let wins = nvim_list_wins()
    "Filter out all floating windows
    if match(a:filter, 'r')
        let wins = filter(wins, {v -> nvim_win_get_config(v:val).relative = ''})
    endif

    return map(wins, {v -> win_id2win(v:val)})
endfunc
