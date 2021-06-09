"pack plugins https://github.com/preservim/nerdtree

let g:NERDTreeChDirMode=0                               "Never change cwd
let g:NERDTreeShowHidden=1                              "Show hidden files
"let g:NERDTreeBookmarksFile

let g:NERDTreeWinPos='right'
let g:NERDTreeStatusline=' '                            "Status line (empty)
let g:NERDTreeMinimalUI=1                               "Don't show help and label
let g:NERDTreeQuitOnOpen=3                              "Always close when file is selected
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'

"Don't show signs, numbers and certain highlights
autocmd FileType nerdtree setl nonumber signcolumn=no colorcolumn= nocursorcolumn

"NOTE This needs to be run once plugin is loaded
"call g:NERDTreePathNotifier.AddListener("init", "MyFoo")

function! MyFoo(event)
    echomsg a:event
endfunction
