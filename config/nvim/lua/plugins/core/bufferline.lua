return {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local nmap = require('core.keymaps').nmap
        local bufferline = require('bufferline')
        local bufferGroups = require('bufferline.groups')
        local CURRENT_GROUP_NAME = 'Proj'

        local function get_all_groups_except(except_groups)
            if type(except_groups) ~= 'table' then
                return {}
            end

            for _, group in ipairs(except_groups) do
                except_groups[group] = true
            end

            local all_groups = vim.fn.keys(bufferGroups.get_all())

            for i = #all_groups, 1, -1 do
                if except_groups[all_groups[i]] then
                    table.remove(all_groups, i)
                end
            end

            return all_groups
        end

        local function toggleOtherGroupsBut(except_groups)
            local all_groups = get_all_groups_except(except_groups)

            for index, _ in ipairs(all_groups) do
                vim.cmd('BufferLineGroupToggle ' .. all_groups[index])
            end
        end

        local function closeOtherGroupsBut(except_groups)
            local all_groups = get_all_groups_except(except_groups)

            for index, _ in ipairs(all_groups) do
                vim.cmd('BufferLineGroupClose ' .. all_groups[index])
            end
        end

        local function selectToggleGroup()
            local groups = get_all_groups_except({ pinned = true, ungrouped = true })

            vim.ui.select(groups, { prompt = 'Select the group you want to toggle' }, function(choice)
                if choice then
                    vim.cmd('BufferLineGroupToggle ' .. choice)
                end
            end)
        end

        nmap('<Tab>', '<cmd>BufferLineCycleNext<CR>', 'Next buffer')
        nmap('<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', 'Previous buffer')

        nmap('<C-Tab>', '<cmd>BufferLineMoveNext<CR>', 'Move current buffer to right')
        nmap('<C-S-Tab>', '<cmd>BufferLineMovePrev<CR>', 'Move current buffer to left')

        nmap('<leader>tp', '<cmd>BufferLineTogglePin<CR>', 'Pin and unpin current buffer')
        nmap('<leader>tg', selectToggleGroup, 'Select a tab group to toggle')
        nmap('<leader>ap', '<cmd>BufferLinePick<CR>', 'Pick a buffer tab')
        nmap('<C-w>W', '<cmd>BufferLineCloseOthers<CR>', 'Close other buffers')
        nmap('<C-w>u', '<cmd>BufferLineGroupClose ungrouped<CR>', 'Close ungrouped buffers')

        nmap('<leader>tc', function()
            toggleOtherGroupsBut({ CURRENT_GROUP_NAME })
        end, 'Toggle other groups but the current one')

        nmap('<C-w>p', function()
            closeOtherGroupsBut({ CURRENT_GROUP_NAME })
        end, 'Close other groups but the current one')

        nmap('<C-w>P', function()
            closeOtherGroupsBut({ 'pinned' })
        end, 'Close unpinned buffers')

        bufferline.setup({
            options = {
                mode = 'buffers', -- set to 'tabs' to only show tabpages instead
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
                        toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
                    },
                    items = {
                        bufferGroups.builtin.pinned:with({ icon = '' }),
                        {
                            name = CURRENT_GROUP_NAME,
                            highlight = {
                                fg = 'lightblue',
                            },

                            auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
                            matcher = function(buf)
                                return buf.path:match('%' .. vim.fn.getcwd() .. '.*')
                            end,
                            separator = { -- Optional
                                style = bufferGroups.separator.tab,
                            },
                        },
                    },
                },
                offsets = {
                    {
                        filetype = 'NvimTree',
                        text = 'File Explorer',
                        text_align = 'center',
                        separator = false,
                    },
                },
            },
        })
    end,
}
