" Language:     Oracle GIE Sprint file
" Maintainer:   Ondrej Balaz <blami@blami.net>

" Enable system ftplugin (don't let b_didftplugin=1)

" Key mappings
" ,b		open backlog
nmap ,b :find backlog<CR>

" Do not expand TAB
set noexpandtab

" Folding
function! GetGIESprintFoldText()
	let num = v:foldend - v:foldstart + 1
	return printf('+-- %2d unplanned tasks', num)
endfunction
function! GetGIESprintFold(lnum)
	let line = getline(a:lnum)
	let bareexpr = '^[^\t]\+\t\+[^\t]\+\t\+[0-9]\+\t.*$'

	" Don't fold empty lines or comments
	if line =~ '^[#\s]*$'
		return '-1'
	endif

	if line =~ bareexpr
		return '1'
	endif

	return '0'
endfunction
set foldmethod=expr
set foldexpr=GetGIESprintFold(v:lnum)
set foldtext=GetGIESprintFoldText()

" Use 16 character TAB
set tabstop=16
set softtabstop=16
set shiftwidth=16

" Don't wrap at 79 column
set fo-=t
