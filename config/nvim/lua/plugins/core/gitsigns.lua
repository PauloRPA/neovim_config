return {
    'lewis6991/gitsigns.nvim',
    tag = 'v0.8.1',
    config = function()
        local events = require('core.events')

        local nmap = require('core.keymaps').nmap
        local git_update_vmap = require('core.keymaps').vevmap(nil, events.git_update)
        local git_update_nmap = require('core.keymaps').nevmap(nil, events.git_update)

        local gs = require('gitsigns.actions')

        -- Navigation
        nmap('<leader>ghn', function()
            if vim.wo.diff then
                return '<leader>gh'
            end
            vim.schedule(function()
                gs.nav_hunk('next')
            end)
            return '<Ignore>'
        end, 'Next hunk', { expr = true })

        nmap('<leader>ghp', function()
            if vim.wo.diff then
                return '<leader>gH'
            end
            vim.schedule(function()
                gs.nav_hunk('prev')
            end)
            return '<Ignore>'
        end, 'Previous hunk', { expr = true })

        -- Hunk
        git_update_nmap('<leader>ghs', gs.stage_hunk, 'Stage hunk')
        git_update_nmap('<leader>ghr', gs.reset_hunk, 'Reset hunk')
        git_update_nmap('<leader>ghu', gs.undo_stage_hunk, 'Undo stage hunk')
        git_update_nmap('<leader>ghk', gs.preview_hunk, 'Preview hunk')

        git_update_vmap('<leader>ghs', function()
            gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Stage hunk')

        git_update_vmap('<leader>ghr', function()
            gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Reset hunk')

        -- Buffer
        git_update_nmap('<leader>gS', gs.stage_buffer, 'Stage buffer')
        git_update_nmap('<leader>gR', gs.reset_buffer, 'Reset buffer')

        -- Actions
        nmap('<leader>gb', function()
            gs.blame_line({ full = true })
        end, 'Blame line')

        nmap('<leader>gtb', gs.toggle_current_line_blame, 'Toggle current line blame')
        nmap('<leader>gtd', gs.toggle_deleted, 'Toggle deleted')
        nmap('<leader>gtl', gs.toggle_linehl, 'Toggle line highlight')
        nmap('<leader>gtn', gs.toggle_numhl, 'Toggle number highlight')
        nmap('<leader>gts', gs.toggle_signs, 'Toggle Signs Column')
        nmap('<leader>gtw', gs.toggle_word_diff, 'Toggle word diff')

        nmap('<leader>gq', function()
            gs.setqflist('attached', { open = false })
            vim.notify('Quickfix updated')
        end, 'Set git changes to quickfix list')
        nmap('<leader>gd', gs.diffthis, 'Diff index')
        nmap('<leader>gD', function()
            gs.diffthis('~1')
        end, 'Diff commit ~1')

        require('gitsigns').setup({
            signs = {
                add = { text = '│' },
                change = { text = '│' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = '┆' },
            },
            signcolumn = false, -- :Gitsigns toggle_signs
            numhl = true, -- :Gitsigns toggle_numhl
            linehl = false, -- :Gitsigns toggle_linehl
            word_diff = false, -- :Gitsigns toggle_word_diff
            diff_opts = {
                internal = true,
            },
        })
    end,
}
