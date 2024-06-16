return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPre' },
    config = function()
        local nmap = require('core.keymaps').nmap

        nmap('<leader>st', '<cmd>TodoTelescope<CR>', 'Search Todos in Telescope')

        -- TODO NOTE HACK WARN FIX PERF TEST
        require('todo-comments').setup({
            signs = false,
            sign_priority = 8,
            highlight = {
                comments_only = true, -- uses treesitter to match keywords in comments only
                exclude = {}, -- list of file types to exclude highlighting
            },
        })
    end,
}
