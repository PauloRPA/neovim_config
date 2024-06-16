return {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
        { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
        require('neoclip').setup({
            on_select = {
                move_to_front = true,
                close_telescope = true,
            },
            on_paste = {
                set_reg = false,
                move_to_front = false,
                close_telescope = false,
            },
            keys = {
                telescope = {
                    i = {
                        select = '<cr>',
                        paste_behind = '<c-p>',
                        paste = '<c-P>',
                        replay = false,
                        delete = '<c-d>',
                        edit = '<c-e>',
                        custom = {},
                    },
                    n = {
                        select = '<cr>',
                        paste = 'p',
                        paste_behind = 'P',
                        replay = false,
                        delete = 'd',
                        edit = 'e',
                        custom = {},
                    },
                },
            },
        })
        local nmap = require('core.keymaps').nmap
        local imap = require('core.keymaps').imap

        nmap('<leader>sc', '<cmd>Telescope neoclip<CR>', 'Search clipboard history')
        imap('<A-P>', '<cmd>Telescope neoclip<CR>', 'Search clipboard history')
    end,
}
