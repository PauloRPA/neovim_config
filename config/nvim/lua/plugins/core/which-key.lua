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
            -- disable = {
            --     buftypes = {},
            --     filetypes = {},
            -- },
        })

        -- VISUAL MODE
        wk.register({
            a = {
                name = 'Action',
                s = {
                    name = 'Snippet',
                    a = 'Add snippet',
                    e = 'Edit snippet',
                },
                w = 'Wrap',
            },
            g = {
                name = 'Git',
                h = 'Hunk',
            },
            d = {
                name = 'Doc+Util',
                c = 'Open documentation for selected text',
            },
        }, { mode = 'v', prefix = '<leader>' })

        -- NORMAL MODE
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
            w = 'Workspace',
            b = {
                name = 'Breakpoint',
            },
            a = {
                name = 'Action',
                w = 'Wrap',
                e = 'Extract',
                a = 'Application specific',
                c = 'CD',
                s = {
                    name = 'Snippet',
                    a = 'Add snippet',
                    e = 'Edit snippet',
                },
            },
        }, { mode = 'n', prefix = '<leader>' })
    end,
}
