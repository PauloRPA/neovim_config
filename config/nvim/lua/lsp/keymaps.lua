M = {}

local nmap = require('core.keymaps').nmap
local opts = { noremap = true, silent = true, buffer = true }

M.attachLspKeymapsToBuf = function()
    nmap('<leader>;', vim.lsp.buf.code_action, 'Code Action', opts)
    nmap('<leader>ao', vim.lsp.buf.code_action, 'Code Action', opts)

    nmap('<A-R>', vim.lsp.buf.rename, 'Rename', opts)
    nmap('<leader>af', vim.lsp.buf.format, 'Format current buffer with LSP', opts)
    nmap('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition', opts)
    nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation', opts)
    nmap('gr', require('telescope.builtin').lsp_references, 'Goto References', opts)

    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder', opts)
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder', opts)

    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'Workspace List Folders', opts)
end

M.attachLspSagaKeymapsToBuf = function()
    nmap('<leader>a<leader>', '<cmd>Lspsaga code_action<CR>', 'Code Action', opts)
    nmap('<leader>ao', '<cmd>Lspsaga code_action<CR>', 'Code Action', opts)

    nmap('gd', '<cmd>Lspsaga goto_definition<CR>', 'Goto Definition', opts)
    nmap('gD', '<cmd>Lspsaga goto_type_definition<CR>', 'Goto type Definition', opts)
    nmap('gr', '<cmd>Lspsaga incoming_calls<CR>', 'Goto References', opts)

    nmap('<leader>of', '<cmd>Lspsaga finder<CR>', 'Open finder', opts)
    nmap('<leader>oc', '<cmd>Lspsaga outgoing_calls<CR>', 'Open outgoing calls', opts)
    nmap('<leader>ol', '<cmd>Lspsaga outline<CR>', 'Toggle outline panel', opts)
    nmap('<leader>os', '<cmd>Lspsaga subtypes<CR>', 'Toggle subtypes', opts)
    nmap('<leader>ou', '<cmd>Lspsaga supertypes<CR>', 'Toggle supertypes', opts)

    nmap('<leader>df', '<cmd>Lspsaga peek_definition<CR>', 'Peek Definition', opts)
    nmap('<leader>dF', '<cmd>Lspsaga peek_type_definition<CR>', 'Peek type Definition', opts)
    nmap('<leader>[', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Goto previous diagnostic', opts)
    nmap('<leader>]', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Goto next diagnostic', opts)

    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder', opts)
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder', opts)

    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'Workspace List Folders', opts)
end

return M
