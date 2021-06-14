"pack plugins https://github.com/norcalli/nvim-colorizer.lua
"Preview hex/rgb(a) colors by setting their background

lua << EOF
--local ok, module = pcall(require colorizer)
--if ok...

require 'colorizer'.setup({
    "css";
    "html";
    "javascript";
    "scss";
    "typescript";
    "vim";
})
EOF
