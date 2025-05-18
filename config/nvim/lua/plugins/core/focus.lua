return {
    'nvim-focus/focus.nvim',
    enabled = true,
    version = '*',
    dependencies = {
        {
            'echasnovski/mini.animate',
            version = false,
            config = function()
                require('mini.animate').setup({
                    cursor = {
                        enable = false,
                    },
                    scroll = {
                        enable = false,
                    },
                    resize = {
                        -- Whether to enable this animation
                        enable = true,

                        -- Timing of animation (how steps will progress in time)
                        timing = function()
                            return 0.1;
                        end
                    },

                })
            end
        },
    },
    config = function()
        local focus = require('focus')
        local focusGroup = vim.api.nvim_create_augroup('focus_group', { clear = true })
        local ignore_filetypes = {
            'NvimTree',
            'dapui_watches',
            'dap-repl',
            'dapui_stacks',
            'dapui_scopes',
            'DiffviewFiles',
            'qf',
            'toggleterm',
            'neotest-summary',
        }

        vim.api.nvim_create_autocmd('FileType', {
            pattern = ignore_filetypes,
            callback = function(_)
                vim.b.focus_disable = true
            end,
            desc = 'Disable focus autoresize for dap-ui buffers',
            group = focusGroup,
        })

        focus.setup({
            enable = true,            -- Enable module
            commands = true,          -- Create Focus commands
            autoresize = {
                enable = true,        -- Enable or disable auto-resizing of splits
                width = 0,            -- Force width for the focused window
                height = 0,           -- Force height for the focused window
                minwidth = 0,         -- Force minimum width for the unfocused window
                minheight = 0,        -- Force minimum height for the unfocused window
                height_quickfix = 10, -- Set the height of quickfix panel
            },
            split = {
                bufnew = false, -- Create blank buffer for new split windows
                tmux = false,   -- Create tmux splits instead of neovim splits
            },
            ui = {
                number = false,                    -- Display line numbers in the focussed window only
                relativenumber = false,            -- Display relative line numbers in the focussed window only
                hybridnumber = false,              -- Display hybrid line numbers in the focussed window only
                absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

                cursorline = true,                 -- Display a cursorline in the focussed window only
                cursorcolumn = false,              -- Display cursorcolumn in the focussed window only
                colorcolumn = {
                    enable = false,                -- Display colorcolumn in the foccused window only
                    list = '+1',                   -- Set the comma-saperated list for the colorcolumn
                },
                signcolumn = true,                 -- Display signcolumn in the focussed window only
                winhighlight = false,              -- Auto highlighting for focussed/unfocussed windows
            },
        })
    end,
}
