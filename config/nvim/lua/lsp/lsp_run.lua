local M = {}
local before_func = {}
local after_func = {}
local on_attach_func = {}

--- Function to run before lspconfig
---@param before_function function to run
M.add_before = function(before_function)
    if type(before_function) ~= 'function' then
        vim.notify('Only functions may run before lspconfig.')
        return
    end
    table.insert(before_func, before_function)
end

--- Function to run after lspconfig
---@param after_function function to run
M.add_after = function(after_function)
    if type(after_function) ~= 'function' then
        vim.notify('Only functions may run after lspconfig.')
        return
    end
    table.insert(after_func, after_function)
end

--- Function to run on_attach lspconfig
---@param on_attach_function function to run
M.add_on_attach = function(on_attach_function)
    if type(on_attach_function) ~= 'function' then
        vim.notify('Only functions may run on_attach lspconfig.')
        return
    end
    table.insert(on_attach_func, on_attach_function)
end

M.before = function()
    for _, func in ipairs(before_func) do
        func()
    end
end

M.after = function()
    for _, func in ipairs(after_func) do
        func()
    end
end

M.on_attach = function()
    for _, func in ipairs(on_attach_func) do
        func()
    end
end

return M
