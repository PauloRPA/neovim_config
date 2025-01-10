local M = {}

local opts = { noremap = true, silent = true }
local iopts = { noremap = false, silent = true }

M.opts = opts
M.iopts = iopts

local function clearLine()
    vim.api.nvim_input('<esc>v0ws') -- Save word under cursor to register t
end

local function map(mode, key, action, description, opt, default_opts, pre, pos)
    if not opt then
        opt = default_opts
    end

    if description then
        opt.desc = description
    end

    local final_action = action

    if pre or pos then
        final_action = function()
            if pre ~= nil and type(pre) == 'function' then
                pre()
            end

            if type(action) == 'string' then
                vim.api.nvim_input(action)
            end

            if type(action) == 'function' then
                action()
            end

            if pos ~= nil and type(pos) == 'function' then
                pos()
            end
        end
    end

    vim.keymap.set(mode, key, final_action, opt)
end

local modeMapFunc = {}
local modeEVMapFunc = {}
---@enum vim_modes
local modes = { 'n', 'i', 'v', 'x', 't', 'o', 's' }

for _, mode in ipairs(modes) do
    M[mode .. 'map'] = function(key, action, description, opt)
        map(mode, key, action, description, opt, opts)
    end
    modeMapFunc[mode] = M[mode .. 'map']
end

for _, mode in ipairs(modes) do
    M[mode .. 'evmap'] = function(pre, pos)
        return function(key, action, description, opt)
            map(mode, key, action, description, opt, opts, pre, pos)
        end
    end
    modeEVMapFunc[mode] = M[mode .. 'evmap']
end

M.multi = function(multimodes, pre, pos)
    local modeMap = type(multimodes) == 'table' and multimodes or {}
    if type(multimodes) == 'string' then
        for ch in multimodes:gmatch('.') do
            table.insert(modeMap, ch)
        end
    end

    if pre or pos then
        return function(key, action, description, opt)
            for _, mode in ipairs(modeMap) do
                local mappingFunction = modeEVMapFunc[mode]
                if mappingFunction then
                    mappingFunction(pre, pos)(key, action, description, opt)
                end
            end
        end
    end

    return function(key, action, description, opt)
        for _, mode in ipairs(modeMap) do
            local mappingFunction = modeMapFunc[mode]
            if mappingFunction then
                mappingFunction(key, action, description, opt)
            end
        end
    end
end

M.fn = {
    clearLine = clearLine,
}

M.load = function()
    local nmap = M.nmap
    local imap = M.imap
    local tmap = M.tmap
    local vmap = M.vmap
    local xmap = M.xmap
    local func = require('core.functions')

    -- Remap for dealing with word wrap
    nmap('k', 'gk', 'Move one line down')
    nmap('j', 'gj', 'Move one line up')

    -- Pane op
    nmap('<C-l>', '<C-w>l', 'Select right pane')
    nmap('<C-h>', '<C-w>h', 'Select left pane')
    nmap('<C-k>', '<C-w>k', 'Select top pane')
    nmap('<C-j>', '<C-w>j', 'Select bottom pane')

    nmap('_', '<C-w>|', 'Maximize pane size')
    nmap('==', '<C-w>=', 'Distribute pane size')

    nmap('<C-d>', '<C-d>z.', 'Move half page up and center')
    nmap('<C-u>', '<C-u>z.', 'Move half page down and center')

    nmap('<C-left>', '4<C-w>>', 'Resize left')
    nmap('<C-right>', '4<C-w><', 'Resize right')
    nmap('<C-up>', '4<C-w>+', 'Resize up')
    nmap('<C-down>', '4<C-w>-', 'Resize down')
    nmap('<leader>og', func.open_current_git_files, 'Open current git files')

    nmap('<C-c>', '<C-w>c', 'Close current pane')

    -- Buffer op
    nmap('<leader>p', '<cmd>b#<CR>', 'Last visited buffer')
    nmap('<leader>j', '<cmd>bp<CR>', 'Previous buffer')
    nmap('<leader>k', '<cmd>bn<CR>', 'Next buffer')
    nmap('<C-w>w', '<cmd>bn|bd#<CR>', 'Close current buffer')
    nmap('<C-w>k', '<cmd>bn|bd#<CR>', 'Close current buffer')

    nmap('<A->>', '<cmd>cnext<CR>', 'Next quickfix item')
    nmap('<A-<>', '<cmd>cprev<CR>', 'Previous quickfix item')

    nmap('<C-s>', vim.cmd.wa, 'Saves all modified buffers')

    -- Emacs keybindings for command line mode
    imap('<A-b>', '<C-Left>', 'Move a word before')
    imap('<A-d>', '<C-o>cw', 'Move a word after')
    imap('<A-f>', '<C-Right>', 'Move a word ahead')

    imap('<C-b>', '<Left>', 'Move a char before')
    imap('<C-f>', '<Right>', 'Move a char ahead')
    imap('<C-e>', '<End>', 'Move to end')
    imap('<C-a>', '<Home>', 'Move to start')
    imap('<C-d>', '<Del>', 'Delete char')
    imap('<C-n>', '<Esc>o', 'New line below')
    imap('<A-n>', '<Esc>o', 'New line below')
    imap('<A-O>', '<Esc>O', 'New line above')

    -- User functions
    nmap('<Space>', '<Nop>', 'Nop')
    imap('<A-p>', '<ESC>pa', 'Paste content and return to insert mode')

    nmap('<leader>dc', function()
        vim.api.nvim_feedkeys('"tyiw', 'x', false) -- Save word under cursor to register t
        vim.cmd('silent! h ' .. vim.fn.getreg('t'))
    end, 'Open documentation for the word under the cursor')

    xmap('<leader>dc', function()
        vim.api.nvim_feedkeys('"ty', 'x', false) -- Save text under selection to register t
        vim.cmd('silent! h ' .. vim.fn.getreg('t'))
    end, '[>] Indent and maintain selection')

    -- Indentation op
    vmap('>', '>gv', '[>] Indent and maintain selection')
    vmap('<', '<gv', '[<] Indent and maintain selection')

    -- Terminal mappings
    tmap('<Esc>', '<C-\\><C-n>', 'Exit terminal mode with escape')

    -- Diagnostic mappings
    nmap('<leader>]', vim.diagnostic.goto_next, 'Goto next diagnostics')
    nmap('<leader>[', vim.diagnostic.goto_prev, 'Goto previous diagnostics')
end

---@class mode_config First letter of the desired vim mode
---@field prefix string Prefix for the wrapper key sequence
---@field suffix string Suffix for the wrapper key sequence
---@field motion string Motion used by the wrapper key sequence

---@class wrapper_mapping Key combo to invoke the wrapper. Or 'default' to set the default mode_config
---@field text string Wrap text
---@field modes string First letter of the desired vim modes
---@field mode_config table<vim_modes, mode_config> First letter of the desired vim mode

---@param wrapper_mappings wrapper_mapping[]
local function map_wrapper(wrapper_mappings)
    local defaults = {
        n = {
            prefix = nil,
            suffix = 'l',
            motion = 'ciw',
        },
        i = {
            prefix = '<Esc>',
            suffix = 'la',
            motion = 'ciw',
        },
        v = {
            prefix = nil,
            suffix = nil,
            motion = 'di',
        },
    }

    if wrapper_mappings.defaults then
        for mode, config in pairs(wrapper_mappings.defaults) do
            if wrapper_mappings.defaults[mode] then
                defaults[mode].prefix = config.prefix or defaults[mode].prefix
                defaults[mode].suffix = config.suffix or defaults[mode].suffix
                defaults[mode].motion = config.motion or defaults[mode].motion
            end
        end
    end

    local func = require('core.functions')
    local keymaps = require('core.keymaps')

    for key, text_modes in pairs(wrapper_mappings) do
        if key == 'default' then
            goto continue
        end

        local mode_mapping = {}
        for ch in text_modes.modes:gmatch('.') do
            table.insert(mode_mapping, ch)
        end

        for _, mode in ipairs(mode_mapping) do
            local mapfunction = keymaps[mode .. 'map']
            if not mapfunction then
                goto next_mode
            end

            mapfunction(key, function()
                local prefix = wrapper_mappings[key][mode] and wrapper_mappings[key][mode].prefix
                    or defaults[mode].prefix
                local suffix = wrapper_mappings[key][mode] and wrapper_mappings[key][mode].suffix
                    or defaults[mode].suffix
                local motion = wrapper_mappings[key][mode] and wrapper_mappings[key][mode].motion
                    or defaults[mode].motion
                func.wrap_text(text_modes.text, prefix, suffix, motion)
            end, 'Wrap ' .. text_modes.text)

            ::next_mode::
        end

        ::continue::
    end
end

M.map_wrapper = map_wrapper
return M
