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
            local opts = { buffer = bufnr}

            local keymaps = require('core.keymaps')
            local nmap = keymaps.nmap
            local vmap = keymaps.vmap

            -- Navigation
            nmap('<leader>ghn', function()
                if vim.wo.diff then return '<leader>gh' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, 'Next hunk', { expr = true, buffer = bufnr })

            nmap('<leader>ghp', function()
                if vim.wo.diff then return '<leader>gH' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, 'Previous hunk', { expr = true, buffer = bufnr })

            -- Hunk
            nmap('<leader>ghs', gs.stage_hunk, 'Stage hunk', opts)
            nmap('<leader>ghr', gs.reset_hunk, 'Reset hunk', opts)
            nmap('<leader>ghu', gs.undo_stage_hunk, 'Undo stage hunk', opts)
            nmap('<leader>ghk', gs.preview_hunk, 'Preview hunk', opts)

            vmap('<leader>ghs', function()
                gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
            end, 'Stage hunk', opts)

            vmap('<leader>ghr', function()
                gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
            end, 'Reset hunk', opts)

            -- Buffer
            nmap('<leader>gS', gs.stage_buffer, 'Stage buffer', opts)
            nmap('<leader>gR', gs.reset_buffer, 'Reset buffer', opts)

            -- Actions
            nmap('<leader>gb', function() gs.blame_line { full = true } end, 'Blame line', opts)

            nmap('<leader>gtb', gs.toggle_current_line_blame, 'Toggle current line blame', opts)
            nmap('<leader>gtd', gs.toggle_deleted, 'Toggle deleted', opts)
            nmap('<leader>gtl', gs.toggle_linehl, 'Toggle line highlight', opts)
            nmap('<leader>gtn', gs.toggle_numhl, 'Toggle number highlight', opts)
            nmap('<leader>gts', gs.toggle_signs, 'Toggle Signs Column', opts)
            nmap('<leader>gtw', gs.toggle_word_diff, 'Toggle word diff', opts)

            nmap('<leader>gd', gs.diffthis, 'Diff index', opts)
            nmap('<leader>gD', function() gs.diffthis('~1') end, 'Diff commit ~1', opts)

        end
    },
}
