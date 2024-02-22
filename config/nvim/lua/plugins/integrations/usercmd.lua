local M = {}

M.event_types = require('plugins.integrations.metaev').types
local usergroup = vim.api.nvim_create_augroup('usercmds', { clear = true })
local event_callbacks = {}

for _, type in pairs(M.event_types) do
    event_callbacks[type] = {}
end

M.fire = function(eventType, data)
    vim.api.nvim_exec_autocmds('User', {
        pattern = eventType,
        group = usergroup,
        data = data,
    })
end

M.addListener = function(eventType, callback)
    if (event_callbacks[eventType] == nil) then return end
    table.insert(event_callbacks[eventType], callback)
end

for _, evType in pairs(M.event_types) do
    vim.api.nvim_create_autocmd('User', {
        pattern = evType,
        group = usergroup,
        callback = function(ev)
            for _, callback in pairs(event_callbacks[evType]) do
                callback(ev)
            end
        end,
        desc = description
    })
end


return M
