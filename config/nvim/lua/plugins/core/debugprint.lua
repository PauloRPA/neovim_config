return {
    'andrewferrier/debugprint.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        local debugprint = require('debugprint')

        debugprint.setup({
            keymaps = {
                normal = {
                    plain_below = '<leader>aJ',
                    plain_above = '<leader>ak',
                    variable_below = '<leader>aj',
                    variable_above = nil,
                    variable_below_alwaysprompt = nil,
                    variable_above_alwaysprompt = nil,
                    textobj_below = nil,
                    textobj_above = nil,
                    toggle_comment_debug_prints = nil,
                    delete_debug_prints = '<leader>ax',
                },
                visual = {
                    variable_below = nil,
                    variable_above = nil,
                },
            },
        })
    end,
}
