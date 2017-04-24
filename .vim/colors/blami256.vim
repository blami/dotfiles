" Theme:        blami256
" Maintainer:   Ondrej Balaz <blami@blami.net>
" License:      MIT

unlet! g:colors_name
hi clear
if exists("syntax_on")
    syntax reset
endif


hi Normal       cterm=NONE

" Gutter
hi LineNr       cterm=NONE   ctermfg=Yellow
hi SignColumn   cterm=NONE ctermbg=NONE ctermfg=Yellow

" Status line







" First set Normal to regular white on black text colors:
"hi Normal ctermfg=LightGray ctermbg=Black guifg=#dddddd	guibg=Black

" Syntax highlighting (other color-groups using default, see :help group-name):
"hi Comment    cterm=NONE ctermfg=DarkCyan    	gui=NONE guifg=#00aaaa   	 
"hi Constant   cterm=NONE ctermfg=LightCyan   	gui=NONE guifg=#00ffff   	
"hi Identifier cterm=NONE ctermfg=LightMagenta   gui=NONE guifg=#ff00ff   
"hi Function   cterm=NONE ctermfg=LightGreen   	gui=NONE guifg=#00ff00   	
"hi Statement  cterm=NONE ctermfg=White	     	gui=bold guifg=#ffffff	     	
"hi PreProc    cterm=NONE ctermfg=Yellow		gui=NONE guifg=#ffff00 	
"hi Type	      cterm=NONE ctermfg=LightGreen	gui=bold guifg=#00ff00 		
"hi Special    cterm=NONE ctermfg=LightRed    	gui=NONE guifg=#ff0000    	
"hi Delimiter  cterm=NONE ctermfg=Yellow    	gui=NONE guifg=#ffff00    	

