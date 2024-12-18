return {
    enabled = true,
    'folke/noice.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
    },
    config = function()
        vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder', { link = 'Title' })
        vim.api.nvim_set_hl(0, 'NoiceCmdlineIcon', { link = 'Title' })

        vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderSearch', { link = 'WarningMsg' })
        vim.api.nvim_set_hl(0, 'NoiceCmdlineIconSearch', { link = 'WarningMsg' })

        vim.o.cmdheight = 0

        local nmap = require('core.keymaps').nmap

        nmap('<leader>o:', '<cmd>Noice last<CR>', 'Last command output')

        require('noice').setup({
            views = {
                cmdline_popup = {},
            },
            presets = {
                long_message_to_split = true, -- long messages will be sent to a split
            },
            cmdline = {
                enabled = true, -- enables the Noice cmdline UI
                view = 'cmdline_popup', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
                opts = {}, -- global options for the cmdline. See section on views
                format = {
                    cmdline = { pattern = '^:', icon = '', lang = 'vim' },
                    search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
                    search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
                    filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
                    lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
                    help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
                    input = { view = 'cmdline_input', icon = '󰥻 ' }, -- Used by input()
                },
            },
            messages = {
                enabled = true, -- enables the Noice messages UI
                view = 'notify', -- default view for messages
                view_error = false, -- view for errors
                view_warn = false, -- view for warnings
                view_history = false, -- view for :messages
                view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
            },
            lsp = {
                progress = {
                    enabled = false,
                },
                override = {
                    -- override the default lsp markdown formatter with Noice
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = false,
                    -- override the lsp markdown formatter with Noice
                    ['vim.lsp.util.stylize_markdown'] = false,
                    -- override cmp documentation with Noice (needs the other options to work)
                    ['cmp.entry.get_documentation'] = false,
                },
                hover = {
                    enabled = false,
                },
                signature = {
                    enabled = false,
                },
                message = {
                    enabled = false,
                },
            },
        })
    end,
}
