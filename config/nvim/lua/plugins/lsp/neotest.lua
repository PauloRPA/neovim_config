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

        nmap('<leader>ts', function()
            neotest.summary.toggle()
        end, 'Toggle neotest summary')
        nmap('<leader>to', function()
            neotest.output.open()
        end, 'Open neotest output')

        neotest.setup({
            status = {
                enabled = true,
                signs = true,
                virtual_text = false,
            },
            diagnostic = {
                enabled = true,
                severity = 1,
            },
            adapters = {
                require('neotest-java')({
                    ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
                }),
            },
        })
    end,
}
