return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local lualine = require('lualine')

        local function getClientNames()
            local names = ''
            for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                names = names .. client.name .. ' '
            end
            return names
        end

        lualine.setup({
            options = {
                icons_enabled = true,
                theme = 'tokyonight',
                component_separators = ' ',
                section_separators = { left = '', right = '' },
                globalstatus = true,
                ignore_focus = { 'NvimTree_1' },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = {
                    {
                        'buffers',
                        hide_filename_extension = true,
                        symbols = {
                            modified = ' ●', -- Text to show when the buffer is modified
                            alternate_file = '󰁣 ', -- Text to show to identify the alternate file
                            directory = '', -- Text to show when the buffer is a directory
                        },
                        max_length = vim.o.columns / 2,
                    },
                },
                lualine_x = { getClientNames, 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
        })
    end,
}
