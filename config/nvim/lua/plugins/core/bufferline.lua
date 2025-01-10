return {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local CURRENT_GROUP_NAME = 'Proj'
        local nmap = require('core.keymaps').nmap
        local bufferline = require('bufferline')
        local bufferGroups = require('bufferline.groups')

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

        nmap('<leader>k', '<cmd>BufferLineCycleNext<CR>', 'Next buffer')
        nmap('<leader>j', '<cmd>BufferLineCyclePrev<CR>', 'Previous buffer')

        nmap('+', '<cmd>BufferLineMoveNext<CR>', 'Move current buffer to right')
        nmap('_', '<cmd>BufferLineMovePrev<CR>', 'Move current buffer to left')

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
                truncate_names = true,
                show_buffer_close_icons = false,
                diagnostics = 'nvim_lsp',
                color_icons = true, -- whether or not to add the filetype icon highlights
                separator_style = 'slope',
                enforce_regular_tabs = false,
                sort_by = function(buffer_a, buffer_b)
                    local modified_a = vim.fn.getftime(buffer_a.path)
                    local modified_b = vim.fn.getftime(buffer_b.path)
                    return modified_a > modified_b
                end,
                groups = {
                    options = {
                        toggle_hidden_on_enter = true,
                    },
                    items = {
                        bufferGroups.builtin.pinned:with({ icon = '' }),
                        {
                            name = CURRENT_GROUP_NAME,
                            auto_close = false,
                            icon = '',
                            matcher = function(buf)
                                return buf.path:match('%' .. vim.fn.getcwd() .. '.*')
                            end,
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
