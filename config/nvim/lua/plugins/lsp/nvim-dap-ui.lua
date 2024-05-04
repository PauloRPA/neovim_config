local M = {
    'rcarriga/nvim-dap-ui',
    commit = 'edfa93f60b189e5952c016eee262d0685d838450',
    dependencies = { 'mfussenegger/nvim-dap', { 'nvim-neotest/nvim-nio', tags = 'v1.8.0' } },
    config = function()
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
            }, {
                elements = { {
                    id = 'console',
                    size = 1
                }, },
                position = 'bottom',
                size = 16
            }, },
        })

        local vmap = require('core.keymaps').vmap
        local nmap = require('plugins.integrations.eventmap').nmap(function()
            dapui.close()
        end, nil)

        local layouts = { {
            name = 'ui',
            layouts = { 1, 2 },
            isOpen = false,
        }, {
            name = 'bottom',
            layouts = { 3 },
            isOpen = false,
        }, {
            name = 'console',
            layouts = { 4 },
            isOpen = false,
        } }

        local lastLayout = ''

        local function toggle_layout_by_name(name, shouldReset)
            for _, layout in ipairs(layouts) do
                if (layout.name ~= name) then goto continue end

                local operation = ''
                for _, layoutNumber in ipairs(layout.layouts) do
                    operation = layout.name == lastLayout and 'close' or 'open'

                    dapui[operation]({
                        layout = layoutNumber,
                        reset = shouldReset,
                    })
                end
                lastLayout = operation == 'close' and '' or layout.name

                ::continue::
            end
        end

        nmap('<A-2>', function()
            toggle_layout_by_name('bottom', true)
        end, 'Toggle reset dapui bottom')

        nmap('<A-3>', function()
            toggle_layout_by_name('ui', true)
        end, 'Toggle dap-ui')

        nmap('<A-9>', function()
            toggle_layout_by_name('console')
        end, 'Toggle dap-ui')

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
}

return M
