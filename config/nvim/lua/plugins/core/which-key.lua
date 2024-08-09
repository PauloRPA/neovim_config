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
        wk.add({
            mode = { 'v' },
            { '<leader>a', group = 'Action' },
            { '<leader>as', group = 'Snippet' },
            { '<leader>asa', desc = 'Add snippet' },
            { '<leader>ase', desc = 'Edit snippet' },
            { '<leader>aw', desc = 'Wrap' },
            { '<leader>d', group = 'Doc+Util' },
            { '<leader>dc', desc = 'Open documentation for selected text' },
            { '<leader>g', group = 'Git' },
            { '<leader>gh', desc = 'Hunk' },
        })

        -- NORMAL MODE
        wk.add({
            { '<leader>a', group = 'Action' },
            { '<leader>aa', desc = 'Application specific' },
            { '<leader>ac', desc = 'CD' },
            { '<leader>ae', desc = 'Extract' },
            { '<leader>as', group = 'Snippet' },
            { '<leader>asa', desc = 'Add snippet' },
            { '<leader>ase', desc = 'Edit snippet' },
            { '<leader>aw', desc = 'Wrap' },
            { '<leader>b', group = 'Breakpoint' },
            { '<leader>d', desc = 'Doc+Util' },
            { '<leader>e', desc = 'Toggle nvim-tree' },
            { '<leader>f', desc = 'Function' },
            { '<leader>g', group = 'Git' },
            { '<leader>gh', desc = 'Hunk' },
            { '<leader>gt', desc = 'Toggle' },
            { '<leader>i', desc = 'TS Select' },
            { '<leader>q', desc = 'Persistence' },
            { '<leader>s', group = 'Search/List' },
            { '<leader>sg', desc = 'Git' },
            { '<leader>t', desc = 'Toggle' },
            { '<leader>w', desc = 'Workspace' },
        })
    end,
}
