" ~/.vim/func.vim: Vim user functions file

function! AutowrapToggle()
" Toggle auto-wrapping.
	if matchstr(&fo, 't') != ''
		set fo-=t
	else
		set fo+=t
	endif
endfunction

function! AutowrapStatus()
" Output >&tw (to statusline) when auto-wrapping is enabled.
	if matchstr(&fo, 't') != ''
		return '>'.&tw
	endif
	return ''
endfunction


" vim:set ft=vim fo-=t:
