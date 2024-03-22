return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    tag = 'v0.9.2',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
        'RRethy/nvim-treesitter-endwise',
        'windwp/nvim-ts-autotag',
    },
    config = function()
        local tsConfig = require('nvim-treesitter.configs')

        -- Extensions
        require('nvim-ts-autotag').setup()
        require('treesitter-context').setup {
            max_lines = 1, -- Values <= 0 mean no limit.
        }

        -- Setup
        tsConfig.setup({
            -- Config
            ensure_installed = {
                'java',
                'lua',
                'html',
                'css',
                'javascript',
                'vimdoc',
                'bash',
                'vim',
            },

            highlight = { enable = true, },
            indent = { disable = { 'python' }, enable = true },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<leader>is',
                    node_incremental = 'K',
                    node_decremental = 'J',
                },
            },

            -- Extensions config
            autotag = { -- autotag plugin - nvim-ts-autotag
                enable = true
            },
            endwise = {
                enable = true,
            },
            textobjects = {
                lsp_interop = {
                    enable = true,
                    border = 'single',
                    floating_preview_opts = {},
                    peek_definition_code = {
                        ['<leader>df'] = '@function.inner',
                        ['<leader>dF'] = '@assignment.outer',
                    },
                },
                select = {
                    enable = true,
                    lookahead = true,

                    keymaps = {
                        ['aa'] = { query = '@parameter.outer', desc = 'outer part of a parameter' },
                        ['ia'] = { query = '@parameter.inner', desc = 'inner part of a parameter' },
                        ['af'] = { query = '@function.outer', desc = 'outer part of a function' },
                        ['if'] = { query = '@function.inner', desc = 'inner part of a function' },
                        ['ac'] = { query = '@conditional.outer', desc = 'outer part of a conditional' },
                        ['ic'] = { query = '@conditional.inner', desc = 'inner part of a conditional' },

                        ['aC'] = { query = '@class.outer', desc = 'outer part of a class' },
                        ['iC'] = { query = '@class.inner', desc = 'inner part of a class' },

                        ['ar'] = { query = '@return.outer', desc = 'outer part of a return statement' },
                        ['ir'] = { query = '@return.inner', desc = 'inner part of a return statement' },

                        ['ad'] = { query = '@assignment.lhs', desc = 'left hand side of an assignment' },
                        ['id'] = { query = '@assignment.rhs', desc = 'right hand side of an assignment' },
                        ['as'] = { query = '@assignment.outer', desc = 'outer part of an assignment' },
                        ['is'] = { query = '@assignment.inner', desc = 'inner part of an assignment' },
                    },
                    selection_modes = {
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = 'V',    -- linewise
                    },
                },

                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>l'] = { query = '@parameter.inner', desc = 'Swap next parameter' },
                        ['<A-J>'] = { query = '@function.outer', desc = 'Swap next function' },
                    },
                    swap_previous = {
                        ['<leader>h'] = { query = '@parameter.inner', desc = 'Swap previous parameter' },
                        ['<A-K>'] = { query = '@function.outer', desc = 'Swap previous function' },
                    },
                },

                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ['<A-j>'] = { query = '@function.outer', desc = 'Go to next function start' },
                        ['<A-l>'] = { query = '@parameter.inner', desc = 'Go to next parameter start' },
                        ['[c'] = { query = '@class.outer', desc = '' },
                    },
                    goto_next_end = {
                        ['<leader>J'] = { query = '@function.outer', desc = 'Go to next function end' },
                    },
                    goto_previous_start = {
                        ['<A-k>'] = { query = '@function.outer', desc = 'Go to previous function start' },
                        ['<A-h>'] = { query = '@parameter.inner', desc = 'Go to previous parameter start' },
                        ['[C'] = { query = '@class.outer', desc = '' },
                    },
                    goto_previous_end = {
                        ['<leader>K'] = { query = '@function.outer', desc = 'Go to previous function end' },
                    },
                },
            },
        })
    end,
}
