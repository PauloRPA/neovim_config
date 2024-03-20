return {
    'rcarriga/nvim-dap-ui',
    commit = 'edfa93f60b189e5952c016eee262d0685d838450',
    dependencies = { 'mfussenegger/nvim-dap', { 'nvim-neotest/nvim-nio', tags = 'v1.8.0' } },
    config = function()
        local dapui = require('dapui')

        local nmap = require('core.keymaps').nmap
        local vmap = require('core.keymaps').vmap

        nmap('<leader>dd', dapui.toggle, 'Toggle dap-ui')

        nmap('<leader>dr', function()
            dapui.toggle({ reset = true })
        end, 'Toggle reset dap-ui')

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

        dapui.setup({
            expand_lines = true,
            force_buffers = true,
            layouts = { {
                elements = { {
                    id = 'repl',
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
                    id = 'watches',
                    size = 0.5
                }, {
                    id = 'console',
                    size = 0.5
                } },
                position = 'bottom',
                size = 9
            } },
        })
    end,
}
