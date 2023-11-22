local M = {}

local opts = { noremap = true, silent = true }
local iopts = { noremap = false, silent = true }

M.opts = opts
M.iopts = iopts

local function map(mode, key, action, description, opt, default_opts)
    if not opt then
        opt = default_opts
    end

    if description then
        opt.desc = description
    end

    vim.keymap.set(mode, key, action, opt);
end

M.nmap = function(key, action, description, opt)
    map('n', key, action, description, opt, opts)
end

M.imap = function(key, action, description, opt)
    map('i', key, action, description, opt, iopts)
end

M.vmap = function(key, action, description, opt)
    map('v', key, action, description, opt, opts)
end

M.load = function()
    local nmap = M.nmap
    local imap = M.imap

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

    nmap('<C-c>', '<C-w>c', 'Close current pane')

    -- Buffer op
    nmap('<Tab>', '<cmd>bn<CR>', 'Next buffer')
    nmap('<S-Tab>', '<cmd>bp<CR>', 'Previous buffer')
    nmap('<leader>p', '<cmd>b#<CR>', 'Previous buffer')
    nmap('<leader>j', '<cmd>bp<CR>', 'Previous buffer')
    nmap('<leader>k', '<cmd>bn<CR>', 'Next buffer')
    nmap('<C-w>w', '<cmd>bn|bd#<CR>', 'Close current buffer')
    nmap('<C-w>k', '<cmd>bn|bd#<CR>', 'Close current buffer')

    nmap('<C-s>', ':wa<CR>', 'Saves all modified buffers')

    -- Emacs keybindings for command line mode
    imap('<A-b>', '<C-Left>', 'Move a word before')
    imap('<A-f>', '<C-Right>', 'Move a word ahead')

    imap('<C-b>', '<Left>', 'Move a char before')
    imap('<C-f>', '<Right>', 'Move a char ahead')
    imap('<C-e>', '<End>', 'Move to end')
    imap('<C-a>', '<Home>', 'Move to start')
    imap('<C-d>', '<Del>', 'Delete char')
    imap('<C-n>', '<Esc>o', 'New line below')

    -- User functions
    nmap('<Space>', '<Nop>', 'Nop')

    nmap('<leader>dc', function()
        vim.api.nvim_feedkeys('"tyiw', 'x', false) -- Save word under cursor to register t
        vim.cmd('silent! h ' .. vim.fn.getreg('t'))
    end, 'Open documentation for the word under the cursor');

    vim.keymap.set('x', '<leader>dc', function()
        vim.api.nvim_feedkeys('"ty', 'x', false) -- Save text under selection to register t
        vim.cmd('silent! h ' .. vim.fn.getreg('t'))
    end, { desc = '[>] Indent and maintain selection' })

    -- Indentation op
    vim.keymap.set('v', '>', '>gv', { desc = '[>] Indent and maintain selection' })
    vim.keymap.set('v', '<', '<gv', { desc = '[<] Indent and maintain selection' })

    -- Terminal mappings
    vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode with escape' })

    -- Diagnostic mappings
    nmap('<leader>]', vim.diagnostic.goto_next, 'Goto next diagnostics')
    nmap('<leader>[', vim.diagnostic.goto_prev, 'Goto previous diagnostics')
end

return M
