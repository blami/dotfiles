"Name:         blami
"Description:  Light and dark theme easy on eyes
"Author:       Ondrej Balaz

hi clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name='blami'

"Basics
hi Normal               guifg=#b2b2b2   guibg=#292b2e
hi NonText              guifg=#44505c   guibg=NONE
hi SpecialKey           guifg=#e3dedd   guibg=NONE
hi MatchParen           guifg=#86dc2f   guibg=NONE
hi TrailSpace           guibg=#e0211d
hi Visual               guifg=NONE      guibg=#444155
hi VisualNC             guifg=NONE      guibg=#3b314d
"hi VisualNOS
hi LineNr               guifg=#44505c   guibg=#212026
hi CursorLine           guifg=NONE      guibg=NONE
hi CursorLineNr         guifg=#b2b2b2   guibg=#212026
hi SignColumn           guifg=#44505c   guibg=#212026
hi ColorColumn          guifg=NONE      guibg=#212026
hi CursorLineFold       guifg=#bc6ec5   guibg=#212026
hi ModeMsg              guifg=#86dc2f   guibg=NONE
hi! link MoreMsg        ModeMsg
hi! link Title          ModeMsg
hi! link Question       ModeMsg 
hi ErrorMsg             guifg=#e0211d   guibg=NONE
hi WarningMsg           guifg=#dc752f   guibg=NONE

"Selection and search
hi Search               guifg=#b1951d   guibg=#292b2e   gui=reverse
hi! link IncSearch      Search

"Folds
hi FoldColumn           guifg=#bc6ec5   guibg=NONE

"Status, Tabs and Splits
"NOTE: statusline is reversed, UserXX colors are for elements
hi StatusLine           guibg=#b2b2b2   guifg=#5d4d7a
hi StatusLineNC         guibg=#727272   guifg=#34323e
hi VertSplit            guibg=#727272   guifg=#34323e
"hi User1                guifg=#
"hi User2                guifg=#

"Popup-menus, Floats and Wild-menu
hi Pmenu                guifg=#9a9aba   guibg=#34323e
hi PmenuSel             guifg=NONE      guibg=#5e5079
hi PmenuSbar            guifg=NONE      guibg=#212026
hi PmenuThumb           guifg=NONE      guibg=#5e5079
hi WildMenu             guifg=#67b11d   guibg=#212026
hi Menu                 guifg=#9a9a9a   guibg=#212026

"Quick-, Location-lists


"Diagnostics (LSP)
"TODO Hint might be too visible?
hi DiagnosticError      guifg=#e0211d
hi DiagnosticWarn       guifg=#dc752f
hi DiagnosticInfo       guifg=#4f97d7
hi DiagnosticHint       guifg=#86dc2f
hi DiagnosticSignError  guifg=#e0211d   guibg=#212026
hi DiagnosticSignWarn   guifg=#dc752f   guibg=#212026
hi DiagnosticSignInfo   guifg=#4f97d7   guibg=#212026
hi DiagnosticSignHint   guifg=#86dc2f   guibg=#212026

"Spellcheck
hi SpellBad             guibg=#3c2a2c   gui=undercurl

"Syntax
hi Boolean          guifg=#dc752f
hi Character        guifg=#bc6ec5
hi Comment          guifg=#2aa1ae
hi Conditional      guifg=#4f97d7
hi Constant         guifg=#e18254
hi Define           guifg=#2d9574
hi Debug            guifg=#f54e3c
hi Delimiter        guifg=#74baac
hi Error            guifg=#212026   guibg=#f2241f
hi Exception        guifg=#f2241f
hi Float            guifg=#b7b7ff
hi Function         guifg=#bc6ec5
hi Identifier       guifg=#7590db
hi Ignore           guifg=fg
hi Include          guifg=#b1951d
hi Keyword          guifg=#4f97d7
hi Label            guifg=#ce537a
hi Macro            guifg=#7590db
hi Number           guifg=#e697e6
hi Operator         guifg=#58b0d9
hi PreCondit        guifg=#a45bad
hi PreProc          guifg=#d698fe
hi Repeat           guifg=#ce537a
hi SpecialChar      guifg=#28def0
hi SpecialComment   guifg=#768294
hi Statement        guifg=#4f97d7
hi StorageClass     guifg=#b1951d
hi Special          guifg=#d79650
hi String           guifg=#2d9574
hi Structure        guifg=#4495b4
hi Tag              guifg=#e18254
"TODO Instead of using Todo I use own CustomTodo (see autload/blami/todo.vim)
hi! link Todo       Comment
hi CustomTodo       guifg=#b1951d   guibg=#212026
hi Type             guifg=#ce537a
hi Typedef          guifg=#b1951d

hi Underlined       guifg=NONE      guibg=NONE      gui=underline
hi Strikethrough    guifg=NONE      guibg=NONE      gui=strikethrough

"Plugins
"


"Language specific (MUST BE LINK TO "Syntax)

    "Plugins
    "LSP
"GitGutterAddInvisible xxx ctermfg=242 ctermbg=242 guifg=bg guibg=#212026
"GitGutterChangeInvisible xxx ctermfg=242 ctermbg=242 guifg=bg guibg=#212026
"GitGutterDeleteInvisible xxx ctermfg=242 ctermbg=242 guifg=bg guibg=#212026
"GitGutterChangeDeleteInvisible xxx links to GitGutterChangeInvisible
"GitGutterAdd   xxx ctermbg=242 guibg=#212026
"GitGutterChange xxx ctermbg=242 guibg=#212026
"GitGutterDelete xxx ctermfg=12 ctermbg=242 guifg=Blue guibg=#212026
"GitGutterChangeDelete xxx links to GitGutterChange
"GitGutterAddLine xxx links to DiffAdd
"GitGutterChangeLine xxx links to DiffChange
"GitGutterDeleteLine xxx links to DiffDelete
"GitGutterChangeDeleteLine xxx links to GitGutterChangeLine
"GitGutterAddLineNr xxx links to CursorLineNr
"GitGutterChangeLineNr xxx links to CursorLineNr
"GitGutterDeleteLineNr xxx links to CursorLineNr
"GitGutterChangeDeleteLineNr xxx links to CursorLineNr
"GitGutterAddIntraLine xxx cterm=reverse gui=reverse
"GitGutterDeleteIntraLine xxx cterm=reverse gui=reverse
"
