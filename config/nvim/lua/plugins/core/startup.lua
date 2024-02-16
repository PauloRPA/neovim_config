return {
    'startup-nvim/startup.nvim',
    tag = 'stable',
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local header_section = {
            type = 'text',
            align = 'center',
            margin = 5,
            content = {
                [[(\"   \|"  \|"  \    /"  ||" \   |"  \    /"  |]],
                [[|.\\   \    |\   \  //  / ||  |   \   \  //   |]],
                [[|: \.   \\  | \\  \/. ./  |:  |   /\\  \/.    |]],
                [[|.  \    \. |  \.    //   |.  |  |: \.        |]],
                [[|    \    \ |   \\   /    /\  |\ |.  \    /:  |]],
                [[\___|\____\)    \__/    (__\_|_)|___|\__/|___|]],
            },
            highlight = 'Title', -- highlight group in which the section text should be highlighted
        }

        local keybindings_section = {
            type = 'mapping', -- can be mapping or oldfiles
            align = 'center',
            margin = 5,
            title = "Basic Commands",
            content = {
                { ' Find File', 'Telescope find_files', '<leader>f' },
                { ' Recent Files', 'Telescope oldfiles', '<leader>o' },
                { ' Colorschemes', 'Telescope colorscheme', '<leader>c' },
                { ' New File', 'lua require"startup".new_file()', '<leader>n' },
                { ' Load last session', 'lua require("persistence").load()', '<leader>l' },
            },
            highlight = 'String', -- highlight group in which the section text should be highlighted
        }

        require('startup').setup({
            header = header_section,
            keybindings = keybindings_section,
            options = {
                mapping_keys = true, -- display mapping
                empty_lines_between_mappings = true,
                disable_statuslines = true,
                paddings = { 3, 8 }, -- amount of empty lines before each section (must be equal to amount of sections)
            },
            mappings = {
                -- execute_command = '<CR>',
                -- open_file = 'o',
                -- open_file_split = '<c-o>',
                -- open_section = '<TAB>',
                -- open_help = '?',
            },
            parts = { 'header', 'keybindings' } -- all sections in order
        })
    end
}
