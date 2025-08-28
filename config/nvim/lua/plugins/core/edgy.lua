return {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    init = function()
        vim.opt.laststatus = 3
        vim.opt.splitkeep = 'screen'
        vim.api.nvim_create_autocmd({ 'BufDelete' }, {
            pattern = { '*' },
            command = 'set cmdheight=0',
            desc = 'set cmdheight=0',
        })
    end,
    opts = {
        exit_when_last = true,
        keys = {
            ['<c-right>'] = function(win) -- increase width
                win:resize('width', 2)
            end,
            ['<c-left>'] = function(win) -- decrease width
                win:resize('width', -2)
            end,
            ['<c-up>'] = function(win) -- increase height
                win:resize('height', 2)
            end,
            ['<c-down>'] = function(win) -- decrease height
                win:resize('height', -2)
            end,
            ['<c-w>='] = function(win) -- reset all custom sizing
                win.view.edgebar:equalize()
            end,
        },
        animate = {
            enabled = true,
            fps = 60,  -- frames per second
            cps = 960, -- cells per second
            on_begin = function()
                vim.g.minianimate_disable = true
            end,
            on_end = function()
                vim.g.minianimate_disable = false
            end,
        },
        bottom = {
            {
                ft = 'toggleterm',
                size = { height = 0.1 },
                filter = function(buf, win) -- exclude floating windows
                    return vim.api.nvim_win_get_config(win).relative == ''
                end,
            },
            'Trouble',
            { ft = 'qf', title = 'QuickFix', size = { height = 0.4 } },
            { ft = 'spectre_panel', size = { height = 0.4 }, },
            { ft = 'dap-repl', size = { height = 0.1 }, },
            { ft = 'dapui_watches', size = { height = 0.1, width = 0.6 }, },
        },
        left = {
            {
                title = 'nvim-tree',
                ft = 'NvimTree',
                filter = function(buf)
                    return vim.bo[buf].buftype == 'nofile'
                end,
                collapsed = false,
                size = { width = 0.1 },
            },
        },
        right = {
            {
                title = 'Database',
                ft = 'dbui',
                collapsed = false,
                size = { width = 0.1 },
            },
            {
                title = 'neotest summary',
                ft = 'neotest-summary',
                size = { width = 0.3 },
            },
            {
                title = 'Help',
                ft = 'markdown',
                size = { width = 0.5 },
                filter = function(buf)
                    return vim.bo[buf].buftype == 'help'
                end,
            },
            {
                title = 'Help',
                ft = 'help',
                size = { width = 0.5 },
            },
            {
                title = 'Dapui stacks',
                ft = 'dapui_stacks',
                size = { width = 0.1 },
            },
            {
                title = 'Dapui scopes',
                ft = 'dapui_scopes',
                size = { width = 0.1 },
            },
        },
    },
}
