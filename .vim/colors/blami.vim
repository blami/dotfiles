"File:          blami.vim
"Name:          blami
"Description:   Simple colortheme

hi clear
if has('syntax')
    syntax reset
endif
let g:colors_name = 'blami'

"TODO: guard various colors by if has()

"hi! Identifier
"hi! Function
"hi! Statement
"hi! Operator
"hi! Constant
"hi! String
"hi! PreProc
hi! Todo                    guibg=#777700   guifg=#000000
hi! link CustomTodo         Todo

"Special/Virtual Text
hi! NonText                 guibg=NONE      guifg=#707070
hi! link EndOfBuffer        NonText
"hi! SpecialKey
"hi! Title

"Statusline and Tabline
"User1-mode, User2-filetype, User3-page, User4-ruler
hi! StatusLine              guibg=#a0a0a0   guifg=#2d2d2c
hi! StatusLineNC            guibg=#a0a0a0   guifg=#5d5d5d
hi! link StatusLineTerm     StatusLine
hi! link StatusLineTermNC   StatusLineNC
hi! User1                   guibg=#000000   guifg=#00ff00
hi! User2                   guibg=#101010   guifg=#dd0000
hi! User3                   guibg=#000000   guifg=#c0c0c0
hi! User4                   guibg=#000000   guifg=#00ffff
"hi! TabLine
"hi! TabLineFill
"hi! TabLineSel

"Gutters
hi! LineNr                  guibg=#000000   guifg=#707070
hi! link LineNrAbove        LineNr
hi! link LineNrBelow        LineNr
hi! link SignColumn         LineNr
hi! ColorColumn             guibg=#1d1d1d   guifg=NONE
hi! VertSplit               guifg=#2d2d2d

"Cursor
"hi! Cursor
"hi! lCursor
"hi! CursorLine
"hi! CursorColumn
"hi! CursorLineNr

"Selection/Highlight
"hi! Visual
"hi! VisualNOS
"hi! Search
"hi! IncSearch
"hi! QuickFixLine
"hi! MatchParen

"Folds
"hi! Folded
"hi! FoldColumn

"Popup Menu
"hi! Pmenu
"hi! PmenuSel
"hi! PmenuKind
"hi! PmenuKindSel
"hi! PmenuExtra
"hi! PmenuExtraSel
"hi! PmenuSbar
"hi! PmenuThumb

"Spellcheck
"hi! SpellBad
"hi! SpellCap
"hi! SpellLocal
"hi! SpellRare

"Diff
"hi! DiffAdd
"hi! DiffChange
"hi! DiffText
"hi! DiffDelete

"Commandline
"hi! Question
"hi! WarningMsg
"hi! ErrorMsg
"hi! ModeMsg
"hi! MoreMsg
