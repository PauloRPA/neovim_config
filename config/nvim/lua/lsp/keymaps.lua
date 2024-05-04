M = {}

local nmap = require('core.keymaps').nmap
local opts = { noremap = true, silent = true, buffer = true }
local dap = require('dap')

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

M.attachDapKeymapsToBuf = function()
    -- Debugging
    nmap('<C-b>', dap.toggle_breakpoint, 'Toggle [B]reakpoint')
    nmap('<A-n>', dap.restart_frame, 'Restart frame')
    nmap('<A-f>', dap.focus_frame, 'Focus frame')
    nmap('<A-o>', dap.step_over, 'Step [O]ver')
    nmap('<A-O>', dap.step_out, 'Step [O]ut')
    nmap('<A-i>', function()
        dap.step_into({ askForTargets = true })
    end, 'Step into')

    -- WARN: Direct reference to dap-ui.
    -- Change this after refactoring the "multiple panes" code
    nmap('<leader>n', function()
        local widgets = require('dap.ui.widgets')
        widgets.cursor_float(widgets.frames).open()
    end, 'Show Frames at cursor')

    -- Breakpoints
    nmap('<leader>bl', dap.list_breakpoints, 'List breakpoints')
    nmap('<leader>bc', dap.clear_breakpoints, 'Clear breakpoints')

    nmap('<leader>bh', function()
        vim.ui.input({ prompt = 'Number of hits' }, function(hits)
            if hits then
                dap.set_breakpoint(nil, hits, nil)
            else
                vim.notify('Operation aborted.')
            end
        end)
    end, 'Set hit breakpoint')

    nmap('<leader>bp', function()
        dap.toggle_breakpoint(nil, nil, vim.api.nvim_get_current_line())
    end, 'Set print breakpoint')

    -- Run
    nmap('<A-r>', function()
        vim.cmd.wa()
        dap.run_last()
    end, 'Run last')

    nmap('<A-x>', function()
        dap.terminate()
    end, 'Terminate')

    nmap('<A-c>', function()
        vim.cmd.wa()
        dap.continue()
    end, 'Dap continue')
end

return M
