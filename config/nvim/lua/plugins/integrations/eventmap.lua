local M = {}

local keymaps = require('core.keymaps')

M.opts = keymaps.opts
M.iopts = keymaps.iopts

local modeMapFunctions = {
    n = keymaps.nmap,
    i = keymaps.imap,
    v = keymaps.vmap,
    x = keymaps.xmap,
    t = keymaps.tmap,
}

local function eventMap(mode, pre, pos)
    return function(key, action, description, opt)
        modeMapFunctions[mode](key, function()
            if pre ~= nil then
                pre()
            end

            if type(action) == 'string' then
                vim.api.nvim_input(action)
            end

            if type(action) == 'function' then
                action()
            end

            if pos ~= nil then
                pos()
            end
        end, description, opt)
    end
end

M.nmap = function(pre, pos)
    return eventMap('n', pre, pos)
end

M.imap = function(pre, pos)
    return eventMap('i', pre, pos)
end

M.vmap = function(pre, pos)
    return eventMap('v', pre, pos)
end

M.xmap = function(pre, pos)
    return eventMap('x', pre, pos)
end

M.tmap = function(pre, pos)
    return eventMap('t', pre, pos)
end

return M
