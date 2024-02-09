return {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local nmap = require('core.keymaps').nmap
        local bufferline = require('bufferline')
        local bufferGroups = require('bufferline.groups')

        local function selectToggleGroup()
            local groupsToIgnore = { pinned = true, ungrouped = true }
            local groups = vim.fn.keys(bufferGroups.get_all())

            for i = #groups, 1, -1 do
                if (groupsToIgnore[groups[i]]) then
                    table.remove(groups, i)
                end
            end

            vim.ui.select(groups, { prompt = 'Select the group you want to toggle' }, function(choice)
                if (choice) then
                    vim.cmd('BufferLineGroupToggle ' .. choice)
                end
            end)
        end

        -- TODO: Create a function so that the user can hide all groups except the current one.
        -- TODO: Create integration module functions so that other plugins can register new tab groups.

        nmap('<Tab>', '<cmd>BufferLineCycleNext<CR>', 'Next buffer')
        nmap('<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', 'Previous buffer')

        nmap('<C-Tab>', '<cmd>BufferLineMoveNext<CR>', 'Move current buffer to right')
        nmap('<C-S-Tab>', '<cmd>BufferLineMovePrev<CR>', 'Move current buffer to left')

        nmap('<leader>tp', '<cmd>BufferLineTogglePin<CR>', 'Pin and unpin current buffer')
        nmap('<leader>tg', selectToggleGroup, 'Select a tab group to toggle')
        nmap('<leader>ap', '<cmd>BufferLinePick<CR>', 'Pick a buffer tab')
        nmap('<C-w>W', '<cmd>BufferLineCloseOthers<CR>', 'Close other buffers')

        bufferline.setup({
            options = {
                mode = 'buffers',           -- set to 'tabs' to only show tabpages instead
                move_wraps_at_ends = false, -- whether or not the move command 'wraps' at the first or last position
                truncate_names = true,
                diagnostics = 'nvim_lsp',
                sort_by = 'id',
                numbers = function(opts)
                    return string.format('%s·%s', opts.raise(opts.ordinal), opts.lower(opts.id))
                end,
                name_formatter = function(buf)
                    return vim.fn.fnamemodify(buf.name, ':t:r')
                end,
                groups = {
                    options = {
                        toggle_hidden_on_enter = true -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
                    },
                    items = {
                        bufferGroups.builtin.pinned:with({ icon = '' }),
                        {
                            name = 'Nvim',
                            highlight = { fg = 'lightblue' },
                            auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
                            matcher = function(buf)
                                return buf.path:match('%onfig/nvim/lua/.*.lua')
                            end,
                            separator = { -- Optional
                                style = bufferGroups.separator.tab
                            },
                        },
                    }
                },
                offsets = {
                    {
                        filetype = 'NvimTree',
                        text = 'File Explorer',
                        text_align = 'center',
                        separator = false,
                    }
                },
            },
        })
    end,
}
