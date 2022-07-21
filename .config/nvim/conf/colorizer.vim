"Configure nvim-colorizer
"NOTE: This runs after nvim-colorizer.lua pack is added.

lua << EOF
colorizer = blami.prequire('colorizer')
if not colorizer then return end

-- Setup gitsigns
colorizer.setup({
    '*';
    --'!filetype'; -- Exclude filetype
}, {
    names = false;
    mode = 'background';
})


EOF
