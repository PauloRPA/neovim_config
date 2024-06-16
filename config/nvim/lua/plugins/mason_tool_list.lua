local M = { tools = {} }

M.addTools = function(tools)
    table.insert(M.tools, tools)
end

return M
