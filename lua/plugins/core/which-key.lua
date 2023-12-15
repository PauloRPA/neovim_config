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
            g = {
                name = 'Git',
                h = 'Hunk',
                t = 'Toggle',
            },
            d = 'Doc+Util',
            i = 'TS Select',
            f = 'Function',
            q = 'Persistence',
        }, { prefix = '<leader>' })
    end
}
