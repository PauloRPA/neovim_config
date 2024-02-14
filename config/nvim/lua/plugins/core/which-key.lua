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
                filetypes = { '' },
            },
        })

        -- FIX: Prefix when staging hunks into Git in visual mode
        wk.register({
            e = 'Toggle nvim-tree',
            s = {
                name = 'Search/List',
                g = 'Git',
            },
            g = {
                name = 'Git',
                h = 'Hunk',
                t = 'Toggle',
            },
            d = 'Doc+Util',
            i = 'TS Select',
            f = 'Function',
            q = 'Persistence',
            t = 'Toggle',
            a = 'Action',
        }, { prefix = '<leader>' })
    end
}
