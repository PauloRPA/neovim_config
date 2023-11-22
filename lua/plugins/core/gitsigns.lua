return {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    priority = 100,
    opts = {
        signs      = {
            add          = { text = '│' },
            change       = { text = '│' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signcolumn = false, -- :Gitsigns toggle_signs
        numhl      = true,  -- :Gitsigns toggle_numhl
        linehl     = false, -- :Gitsigns toggle_linehl
        word_diff  = false, -- :Gitsigns toggle_word_diff
        diff_opts = {
            internal = true
        },
        on_attach  = function(bufnr)
            local gs = require('gitsigns')
            local opts = {}

            local function nmap(lhs, rhs, desc)
                opts.desc = desc
                opts.buffer = bufnr
                vim.keymap.set('n', lhs, rhs, opts)
            end

            local function vmap(lhs, rhs, desc)
                opts.desc = desc
                opts.buffer = bufnr
                vim.keymap.set('v', lhs, rhs, opts)
            end

            -- Navigation
            vim.keymap.set('n', '<leader>ghn', function()
                if vim.wo.diff then return '<leader>gh' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = 'Next hunk'})

            vim.keymap.set('n', '<leader>ghp', function()
                if vim.wo.diff then return '<leader>gH' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = 'Previous hunk' })

            -- Hunk
            nmap('<leader>ghs', gs.stage_hunk, 'Stage hunk')
            nmap('<leader>ghr', gs.reset_hunk, 'Reset hunk')
            nmap('<leader>ghu', gs.undo_stage_hunk, 'Undo stage hunk')
            nmap('<leader>ghk', gs.preview_hunk, 'Preview hunk')

            vmap('<leader>ghs', function()
                gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
            end, { buffer = bufnr, desc = { 'Stage hunk' } })

            vmap('<leader>ghr', function()
                gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
            end, { buffer = bufnr, desc = { 'Reset hunk' } })

            -- Buffer
            nmap('<leader>gS', gs.stage_buffer, 'Stage buffer')
            nmap('<leader>gR', gs.reset_buffer, 'Reset buffer')

            -- Actions
            nmap('<leader>gb', function() gs.blame_line { full = true } end, 'Blame line')

            nmap('<leader>gtb', gs.toggle_current_line_blame, 'Toggle current line blame')
            nmap('<leader>gtd', gs.toggle_deleted, 'Toggle deleted')
            nmap('<leader>gtl', gs.toggle_linehl, 'Toggle line highlight')
            nmap('<leader>gtn', gs.toggle_numhl, 'Toggle number highlight')
            nmap('<leader>gts', gs.toggle_signs, 'Toggle Signs Column')
            nmap('<leader>gtw', gs.toggle_word_diff, 'Toggle word diff')

            nmap('<leader>gd', gs.diffthis, 'Diff index')
            nmap('<leader>gD', function() gs.diffthis('~1') end, 'Diff commit ~1')

        end
    },
}
