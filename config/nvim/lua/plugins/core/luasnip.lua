return {
    'L3MON4D3/LuaSnip',
    tag = 'v2.2.0',
    dependencies = {
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        'honza/vim-snippets',
    },

    config = function()
        local luasnip = require('luasnip')
        local types = require('luasnip.util.types')

        local smap = require('core.keymaps').smap
        local imap = require('core.keymaps').imap

        function next_option()
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            end
        end

        function prev_option()
            if luasnip.choice_active() then
                luasnip.change_choice(-1)
            end
        end

        imap('<C-j>', function() next_option() end, 'Next snippet option')
        imap('<C-k>', function() prev_option() end, 'Previous snippet option')
        smap('<C-j>', function() next_option() end, 'Next snippet option')
        smap('<C-k>', function() prev_option() end, 'Previous snippet option')

        smap('<C-h>', 's<BS>', 'Remove the selected text and enter insert mode')
        smap('<A-h>', 's<BS>', 'Remove the selected text and enter insert mode')
        smap('<BS>', 's<BS>', 'Remove the selected text and enter insert mode')

        imap('<A-h>', '<Nop>', 'Nothing!')

        imap('<A-j>', function() luasnip.jump(1) end, 'Jump to the next portion of the current snippet')
        imap('<A-k>', function() luasnip.jump(-1) end, 'Jump to the previous portion of the current snippet')
        smap('<A-j>', function() luasnip.jump(1) end, 'Jump to the next portion of the current snippet')
        smap('<A-k>', function() luasnip.jump(-1) end, 'Jump to the previous portion of the current snippet')

        luasnip.config.setup({
            region_check_events = { 'InsertEnter', 'CursorMoved', 'CursorHold' },
            delete_check_events = { 'InsertLeave' },
            enable_autosnippets = false,
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { '', 'WarningMsg' } }
                    }
                },
                [types.insertNode] = {
                    passive = {
                        virt_text = { { '', 'LineNr' } }
                    },
                    active = {
                        virt_text = { { '', 'Title' } }
                    },
                    visited = {
                        virt_text = { { '', 'Directory' } }
                    },
                }
            },
        })

        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_snipmate').lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load { paths = { vim.fn.stdpath("config") .. '/lua/snippets' } }
    end
}
