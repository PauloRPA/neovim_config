return {
    'nvimdev/dashboard-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter',
    config = function()
        local header = {
            [[(\"   \|"  \|"  \    /"  ||" \   |"  \    /"  |]],
            [[|.\\   \    |\   \  //  / ||  |   \   \  //   |]],
            [[|: \.   \\  | \\  \/. ./  |:  |   /\\  \/.    |]],
            [[|.  \    \. |  \.    //   |.  |  |: \.        |]],
            [[|    \    \ |   \\   /    /\  |\ |.  \    /:  |]],
            [[\___|\____\)    \__/    (__\_|_)|___|\__/|___|]],
            [[                                                ]],
        }

        require('dashboard').setup({
            theme = 'hyper',
            config = {
                header = header,
                disable_move = true,
                week_header = {
                    enable = false,
                },
                shortcut = {
                    { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                    {
                        icon = ' ',
                        icon_hl = '@variable',
                        desc = 'New file',
                        group = 'ModeMsg',
                        action = 'enew',
                        key = 'n',
                    }, {
                    icon = ' ',
                    icon_hl = '@Title',
                    desc = 'Files',
                    group = 'Label',
                    action = 'Telescope find_files',
                    key = 'f',
                }, {
                    desc = ' Colorscheme',
                    group = 'DiagnosticHint',
                    action = 'Telescope colorscheme',
                    key = 'c',
                }, {
                    desc = '󰉉 Load session',
                    group = 'Number',
                    action = 'lua require("persistence").load()',
                    key = 'l',
                },{
                    desc = '󰊢 Load Git',
                    group = 'Directory',
                    action = 'lua require("core.functions").open_current_git_files()',
                    key = 'g',
                }, {
                    desc = '󰉉 Old files',
                    group = 'NonText',
                    action = 'Telescope oldfiles',
                    key = 'o',
                }, {
                    desc = '󰉉 Quit',
                    group = 'ErrorMsg',
                    action = 'qa',
                    key = 'q',
                },
                },
            },
        })
    end
};
