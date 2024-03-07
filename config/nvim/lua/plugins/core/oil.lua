return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local oil = require('oil')

        local nmap = require('core.keymaps').nmap

        nmap('-', function()
            oil.open_float(nil) -- nil open the parent of the current buffer.
        end, 'Open parent directory')

        oil.setup({
            default_file_explorer = false,
            columns = {
                'icon',
            },
            buf_options = {
                buflisted = false,
                bufhidden = 'hide',
            },
            -- Window-local options to use for oil buffers
            win_options = {
                wrap = false,
                signcolumn = 'no',
                cursorcolumn = false,
                foldcolumn = '0',
                spell = false,
                list = false,
                conceallevel = 3,
                concealcursor = 'nvic',
            },
            lsp_file_methods = {
                autosave_changes = true
            },
            delete_to_trash = false,
            skip_confirm_for_simple_edits = false,
            cleanup_delay_ms = 2000,
            constrain_cursor = 'editable',
            experimental_watch_for_changes = true,
            keymaps = {
                ['g?'] = 'actions.show_help',
                ['<CR>'] = 'actions.select',
                ['<C-s>'] = 'actions.select_vsplit',
                ['<C-h>'] = 'actions.select_split',
                ['<C-t>'] = 'actions.select_tab',
                ['<Tab>'] = 'actions.preview',
                ['<C-c>'] = 'actions.close',
                ['<Esc>'] = 'actions.close',
                ['<C-l>'] = 'actions.refresh',
                ['-'] = 'actions.parent',
                ['_'] = 'actions.open_cwd',
                ['`'] = 'actions.cd',
                ['~'] = 'actions.tcd',
                ['gs'] = 'actions.change_sort',
                ['gx'] = 'actions.open_external',
                ['g.'] = 'actions.toggle_hidden',
                ['g\\'] = 'actions.toggle_trash',
            },
            -- Configuration for the floating keymaps help window
            keymaps_help = {
                border = 'rounded',
            },
            use_default_keymaps = true,
            view_options = {
                show_hidden = false,
                is_hidden_file = function(name, _)
                    return vim.startswith(name, '.')
                end,
                is_always_hidden = function(_, _)
                    return false
                end,
                sort = {
                    { 'type', 'asc' },
                    { 'name', 'asc' },
                },
            },
            float = {
                padding = 2,
                max_width = 0,
                max_height = 0,
                border = 'rounded',
                win_options = {
                    winblend = 0,
                },
                override = function(conf)
                    return conf
                end,
            },
            preview = {
                max_width = 0.9,
                min_width = { 40, 0.4 },
                width = nil,
                max_height = 0.9,
                min_height = { 5, 0.1 },
                height = nil,
                border = 'rounded',
                win_options = {
                    winblend = 0,
                },
                update_on_cursor_moved = true,
            },
            progress = {
                max_width = 0.9,
                min_width = { 40, 0.4 },
                width = nil,
                max_height = { 10, 0.9 },
                min_height = { 5, 0.1 },
                height = nil,
                border = 'rounded',
                minimized_border = 'none',
                win_options = {
                    winblend = 0,
                },
            },
            ssh = {
                border = 'rounded',
            },
        })
    end
}
