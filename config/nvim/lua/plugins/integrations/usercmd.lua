local M = {}

M.event_types = require('plugins.integrations.metaev').types

local event_callbacks = {}

for _, type in pairs(M.event_types) do
    event_callbacks[type] = {}
end

M.fire = function(eventType)
    for _, callback in pairs(event_callbacks[eventType]) do
        callback()
    end
end

M.addUserCmd = function(pattern, eventType, description)
    if (event_callbacks[eventType] == nil) then return end

    vim.api.nvim_create_autocmd('User', {
        pattern = pattern,
        callback = function()
            for _, callback in pairs(event_callbacks[eventType]) do
                callback()
            end
        end,
        desc = description
    })
end

M.addListener = function(eventType, callback)
    if (event_callbacks[eventType] == nil) then return end
    table.insert(event_callbacks[eventType], callback)
end

return M
