return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local lualine = require('lualine')
        local client_names = require('core.functions').get_attached_lsp_client_names

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
                lualine_x = {
                    client_names,
                    require('recorder').recordingStatus,
                    require('recorder').displaySlots,
                    'encoding',
                    'fileformat',
                    'filetype',
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
        })
    end,
}
