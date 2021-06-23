--- Set of Nvim utilities.

local M = {}

-- Import submodules
M.lsp = require("blami.lsp")                    -- LSP related utilities


--- Protected require.
function M.prequire(name)
    local found, m = pcall(require, name)
    if not found then
        -- TODO Drop message to history?
        return nil
    end
    return m
end


return M
