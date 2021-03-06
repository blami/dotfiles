"Name:         blami
"Description:  Light and dark theme easy on eyes
"Author:       Ondrej Balaz

hi clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name='blami'

"Neutral colors


if &background ==# 'dark'
    "Dark theme

    hi Normal           guifg=#b2b2b2   guibg=#292b2e
    hi NonText          guifg=#44505c   guibg=NONE
    hi Visual           guifg=NONE      guibg=#544a65
    hi LineNr           guifg=#44505c   guibg=#212026
    hi CursorLine       guifg=NONE      guibg=NONE
    hi CursorLineNr     guifg=#b2b2b2   guibg=#212026
    hi SignColumn       guifg=#44505c   guibg=#212026
    hi ColorColumn      guifg=NONE      guibg=#212026
    hi FoldColumn       guifg=#bc6ec5   guibg=NONE
    hi ModeMsg          guifg=#67b11d   guibg=NONE
    hi ErrorMsg         guifg=#292b2e   guibg=#f2241f
    hi WarningMsg       guifg=#292b2e   guibg=#e18254

    hi MatchParen       guifg=#67b11d   guibg=NONE

    "Selection and search
    hi IncSearch        guifg=#e18254   guibg=#292b2e   gui=reverse

    "Status, tabs and split
    "NOTE statusline is reversed, UserXX colors are for elements
    hi StatusLine       guibg=#b2b2b2   guifg=#5d4d7a
    hi StatusLineNC     guibg=#727272   guifg=#34323e
    hi VertSplit        guibg=#727272   guifg=#34323e

    "Popup and wildmenu
    hi Pmenu            guifg=#9a9aba   guibg=#34323e
    hi PmenuSel         guifg=NONE      guibg=#5e5079
    hi PmenuSbar        guifg=NONE      guibg=#212026
    hi PmenuThumb       guifg=NONE      guibg=#5e5079
    hi WildMenu         guifg=#67b11d   guibg=#212026
    hi Menu             guifg=#9a9a9a   guibg=#212026

    "Syntax
    hi Boolean          guifg=#dc752f
    hi Character        guifg=#bc6ec5
    hi Comment          guifg=#2aa1ae
    hi Conditional      guifg=#4f97d7
    hi Constant         guifg=#e18254
    hi Define           guifg=#2d9574
    hi Debug            guifg=#f54e3c
    hi Delimiter        guifg=#74baac
    hi Error            guifg=#f2241f
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
    hi Title            guifg=#2d9574
    hi Todo             guifg=#e18254   guibg=#212026
    hi Type             guifg=#ce537a
    hi Typedef          guifg=#b1951d

    hi Underlined       guifg=NONE      guibg=NONE      gui=underline
    hi Strikethrough    guifg=NONE      guibg=NONE      gui=strikethrough

    "Language specific (MUST BE LINK TO "Syntax)

    "Plugins
    "LSP
    hi LspDiagnosticsDefaultError       guifg=#f2241f   guibg=#212026
    hi LspDiagnosticsVirtualTextError   guifg=#f2241f   guibg=NONE
"LspDiagnosticsDefaultError xxx guifg=#f2241f guibg=#212026
"CompeDocumentation xxx links to NormalFloat
"LspDiagnosticsDefaultHint xxx guifg=LightGrey
"LspDiagnosticsVirtualTextHint xxx links to LspDiagnosticsDefaultHint
"LspDiagnosticsFloatingHint xxx links to LspDiagnosticsDefaultHint
"LspDiagnosticsSignHint xxx links to LspDiagnosticsDefaultHint
"LspDiagnosticsVirtualTextError xxx links to LspDiagnosticsDefaultError
"LspDiagnosticsFloatingError xxx links to LspDiagnosticsDefaultError
"LspDiagnosticsSignError xxx links to LspDiagnosticsDefaultError
"LspDiagnosticsDefaultWarning xxx guifg=Orange
"LspDiagnosticsVirtualTextWarning xxx links to LspDiagnosticsDefaultWarning
"LspDiagnosticsFloatingWarning xxx links to LspDiagnosticsDefaultWarning
"LspDiagnosticsSignWarning xxx links to LspDiagnosticsDefaultWarning
"LspDiagnosticsDefaultInformation xxx guifg=LightBlue
"LspDiagnosticsVirtualTextInformation xxx links to LspDiagnosticsDefaultInformation
"LspDiagnosticsFloatingInformation xxx links to LspDiagnosticsDefaultInformation
"LspDiagnosticsSignInformation xxx links to LspDiagnosticsDefaultInformation
"               xxx cleared
"LspDiagnosticsUnderlineError xxx cterm=underline gui=underline guisp=Red
"LspDiagnosticsUnderlineWarning xxx cterm=underline gui=underline guisp=Orange
"LspDiagnosticsUnderlineInformation xxx cterm=underline gui=underline guisp=LightBlue
"LspDiagnosticsUnderlineHint xxx cterm=underline gui=underline guisp=LightGrey
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
else
    "Light theme
    hi! Normal          guifg=#655370   guibg=#eee8d5

endif
