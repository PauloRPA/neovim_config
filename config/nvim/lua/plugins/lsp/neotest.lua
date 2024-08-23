return {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',

        'rcasia/neotest-java',
    },
    config = function()
        local neotest = require('neotest')
        local nmap = require('core.keymaps').nmap

        nmap('<leader>ot', function()
            neotest.summary.toggle()
        end, 'Toggle neotest summary')

        nmap('<leader>oo', function()
            neotest.output.open()
        end, 'Open neotest output')

        nmap('<leader>oO', function()
            neotest.output_panel.toggle()
        end, 'Open neotest output panel')

        neotest.setup({
            output = {
                enabled = true,
                open_on_run = false,
            },
            status = {
                enabled = true,
                signs = true,
                virtual_text = true,
            },
            adapters = {
                require('neotest-java')({
                    ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
                }),
            },
        })
    end,
}
