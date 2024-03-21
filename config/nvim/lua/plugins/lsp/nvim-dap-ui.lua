local M = {
    'rcarriga/nvim-dap-ui',
    commit = 'edfa93f60b189e5952c016eee262d0685d838450',
    dependencies = { 'mfussenegger/nvim-dap', { 'nvim-neotest/nvim-nio', tags = 'v1.8.0' } },
}

M.config = function()
    local dapui = require('dapui')

    dapui.setup({
        expand_lines = true,
        force_buffers = true,
        layouts = { {
            elements = { {
                id = 'watches',
                size = 0.50
            }, {
                id = 'scopes',
                size = 0.25
            }, {
                id = 'stacks',
                size = 0.25
            } },
            position = 'right',
            size = 60
        }, {
            elements = { {
                id = 'repl',
                size = 0.5
            }, {
                id = 'console',
                size = 0.5
            } },
            position = 'bottom',
            size = 7
        }, {
            elements = { {
                id = 'watches',
                size = 0.5
            }, {
                id = 'repl',
                size = 0.5
            } },
            position = 'bottom',
            size = 14
        }, },
    })

    local layouts = { { name = 'ui', 1, 2 }, { name = 'bottom', 3 } }
    local operations = { 'open', 'close', 'toggle' }
    local lastLayout = nil

    -- ────────────────────────────────────────────────────────────────────────────
    -- TODO: A proper way to deal with multiple panes
    -- HACK: Clean this mess as soon as possible
    for _, op in ipairs(operations) do
        for _, layout in ipairs(layouts) do
            M[op .. '_' .. layout.name] = function(closeOthers)
                for _, win in ipairs(layout) do
                    if closeOthers then
                        for key, _ in pairs(M) do
                            if type(key) == 'string' and key:match('close_.*') and type(M[key]) == 'function' then
                                if not key:match('.*_' .. layout.name) and not key:match('.*_reset_.*') then
                                    M[key](false)
                                    lastLayout = layout.name
                                end
                            end
                        end
                    end
                    dapui[op]({
                        layout = win,
                    })
                end
            end

            M[op .. '_reset_' .. layout.name] = function(closeOthers)
                for _, win in ipairs(layout) do
                    if closeOthers then
                        for key, _ in pairs(M) do
                            if type(key) == 'string' and key:match('close_.*') and type(M[key]) == 'function' then
                                if not key:match('.*_' .. layout.name) and not key:match('.*_reset_.*') then
                                    M[key](false)
                                    lastLayout = layout.name
                                end
                            end
                        end
                    end
                    dapui[op]({
                        layout = win,
                        reset = true,
                    })
                end
            end
        end
    end
    -- ────────────────────────────────────────────────────────────────────────────

    local nmap = require('core.keymaps').nmap
    local vmap = require('core.keymaps').vmap
    local usercmds = require('plugins.integrations.usercmd')
    usercmds.addListener(usercmds.event_types.DebuggerWindowPersistence, function()
        if lastLayout then
            M['toggle_' .. lastLayout]()
        end
    end)

    nmap('<A-3>', function()
        M.toggle_reset_ui(true)
    end, 'Toggle dap-ui')
    nmap('<leader>dd', function()
        M.toggle_ui(true)
    end, 'Toggle reset dap-ui')
    nmap('<A-2>', function()
        M.toggle_reset_bottom(true)
    end, 'Toggle reset dapui bottom')

    nmap('<A-e>', dapui.eval, 'Open dap-ui')
    vmap('<A-e>', dapui.eval, 'Open dap-ui')

    nmap('<A-w>', function()
        vim.api.nvim_feedkeys('"tyiw', 'x', false) -- Save word under cursor to register t
        dapui.elements.watches.add(vim.fn.getreg('t'));
    end, 'Open dap-ui')

    vmap('<A-w>', function()
        vim.api.nvim_feedkeys('"ty', 'x', false)
        dapui.elements.watches.add(vim.fn.getreg('t'));
    end, 'Open dap-ui')
end

return M
