return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'windwp/nvim-ts-autotag',
    },
    config = function()
        local tsConfig = require('nvim-treesitter.configs')

        -- Extensions
        require('nvim-ts-autotag').setup()

        -- Setup
        tsConfig.setup({
            -- Config
            ensure_installed = {
                'java',
                'lua',
                'markdown',
                'html',
                'css',
                'javascript',
                'vimdoc',
                'bash',
            },

            highlight = { enable = true, },
            indent = { disable = { 'python' }, enable = true },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<leader>is',
                    node_incremental = 'K',
                    node_decremental = 'J',
                    scope_incremental = '>',
                },
            },

            -- Extensions config
            autotag = { -- autotag plugin - nvim-ts-autotag
                enable = true
            },

            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,

                    keymaps = {
                        ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter' },
                        ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter' },
                        ['af'] = { query = '@function.outer', desc = 'Select outer part of a function' },
                        ['if'] = { query = '@function.inner', desc = 'Select inner part of a function' },
                        ['ac'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional' },
                        ['ic'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },

                        ['aC'] = { query = '@class.outer', desc = 'Select outer part of a class' },
                        ['iC'] = { query = '@class.inner', desc = 'Select inner part of a class' },

                        ['ar'] = { query = '@return.outer', desc = 'Select outer part of a return statement' },
                        ['ir'] = { query = '@return.inner', desc = 'Select inner part of a return statement' },

                        ['hs'] = { query = '@assignment.lhs', desc = 'Select left hand side of an assignment' },
                        ['ls'] = { query = '@assignment.rhs', desc = 'Select right hand side of an assignment' },
                        ['as'] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
                        ['is'] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
                    },
                    selection_modes = {
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = 'V',    -- linewise
                    },
                },

                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>l'] = { query = '@parameter.inner', desc = '' },
                        ['<leader>fj'] = { query = '@function.inner', desc = '' },
                    },
                    swap_previous = {
                        ['<leader>h'] = { query = '@parameter.inner', desc = '' },
                        ['<leader>fk'] = { query = '@function.inner', desc = '' },
                    },
                },

                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ['<leader>j'] = { query = '@function.outer', desc = '' },
                        ['[c'] = { query = '@class.outer', desc = '' },
                    },
                    goto_next_end = {
                        ['<leader>J'] = { query = '@function.outer', desc = '' },
                    },
                    goto_previous_start = {
                        ['<leader>k'] = { query = '@function.outer', desc = '' },
                        ['[C'] = { query = '@class.outer', desc = '' },
                    },
                    goto_previous_end = {
                        ['<leader>K'] = { query = '@function.outer', desc = '' },
                    },
                },
            },
        })
    end,
}
