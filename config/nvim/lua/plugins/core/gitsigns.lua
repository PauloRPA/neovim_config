return {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    priority = 100,
    tag = 'v0.7',
    config = function()

        local gs = require('gitsigns')

        local keymaps = require('core.keymaps')
        local nmap = keymaps.nmap
        local vmap = keymaps.vmap

        -- Integrations
        local usercmds = require('plugins.integrations.usercmd')
        local gitStatusUpdateEvent = usercmds.event_types.GitStatusUpdate
        usercmds.addUserCmd('GitSignsUpdate', gitStatusUpdateEvent,
            'Gitsigns made a change to the current git repository')

        -- Navigation
        nmap('<leader>ghn', function()
            if vim.wo.diff then return '<leader>gh' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, 'Next hunk', { expr = true })

        nmap('<leader>ghp', function()
            if vim.wo.diff then return '<leader>gH' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, 'Previous hunk', { expr = true })

        -- Hunk
        nmap('<leader>ghs', gs.stage_hunk, 'Stage hunk')
        nmap('<leader>ghr', gs.reset_hunk, 'Reset hunk')
        nmap('<leader>ghu', gs.undo_stage_hunk, 'Undo stage hunk')
        nmap('<leader>ghk', gs.preview_hunk, 'Preview hunk')

        vmap('<leader>ghs', function()
            gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
        end, 'Stage hunk')

        vmap('<leader>ghr', function()
            gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
        end, 'Reset hunk')

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

        require('gitsigns').setup({
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
            diff_opts  = {
                internal = true
            },
        })
    end,
}
