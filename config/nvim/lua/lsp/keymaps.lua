M = {}

local nmap = require('core.keymaps').nmap
local opts = { noremap = true, silent = true, buffer = true }

M.attachLspKeymapsToBuf = function()
    nmap('<leader>a<leader>', vim.lsp.buf.code_action, 'Code Action', opts)
    nmap('<leader>ao', vim.lsp.buf.code_action, 'Code Action', opts)

    nmap('<leader>ar', vim.lsp.buf.rename, 'Rename', opts)
    nmap('<leader>af', vim.lsp.buf.format, 'Format current buffer with LSP', opts)
    nmap('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition', opts)
    nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation', opts)
    nmap('gr', require('telescope.builtin').lsp_references, 'Goto References', opts)

    nmap('<C-s>', function()
        vim.lsp.buf.format()
        vim.cmd.wa()
    end, 'Saves all modified buffers')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder', opts)
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder', opts)

    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'Workspace List Folders', opts)
end


return M
