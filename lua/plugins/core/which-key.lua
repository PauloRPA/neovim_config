return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 400
    end,
    config = function()
        local wk = require('which-key')

        wk.setup({
            disable = {
                buftypes = {},
                filetypes = {''},
            },
        })

        wk.register({
            e = 'Toggle nvim-tree',
        }, { prefix = '<leader>' })
    end
}
