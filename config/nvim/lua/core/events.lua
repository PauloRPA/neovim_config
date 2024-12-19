local M = {
    git_update = 'git_update',
    tree_persistence = 'tree_persistence',
    debbuger_window_persistence = 'debbuger_window_persistence',
}

local callbacks = {}
local types = {}

for _, event in pairs(M) do
    types[event] = event
end

local function new_notify_listener(event, callback_runner)
    --- Call this function with a parameter to add a listener and without one to notify
    ---@param new_listener_callback function Callback to run on notify
    return function(new_listener_callback)
        if new_listener_callback == nil then
            for _, notify_callback in pairs(callbacks[event]) do
                callback_runner(notify_callback)
            end
            return
        end

        if type(new_listener_callback) ~= 'function' then
            return
        end

        if not types[event] then
            return
        end

        table.insert(callbacks[event], new_listener_callback)
    end
end

for _, event in pairs(types) do
    callbacks[event] = {}

    M[event] = new_notify_listener(event, function(callback)
        callback()
    end)

    M['async_' .. event] = new_notify_listener(event, function(callback)
        vim.schedule(callback)
    end)
end

M.events = types
return M
