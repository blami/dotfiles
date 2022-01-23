-- Protected silent require statement.
-- 
-- This will either return required module or nil if it does not exists.
function prequire(name)
    local ok, module = pcall(require, name)
    if ok then
        return module
    end
    return nil
end

return prequire
