"Packs
"NOTE: For pack names see ~/ops/ansible/roles/user/vars/main.yml

"{{{ Packs loaded only if not running in VSCode
if !exists('g:vscode')
    call blami#pack#Add(
                \ 'lspconfig',
                \ 'treesitter',
                \ 'gitsigns',
                \ 'colorizer',
                \ )
endif
"}}}
