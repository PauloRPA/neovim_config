return {
    'lewis6991/gitsigns.nvim',
    -- tag = 'v0.7',
    config = function()
        local gs = require('gitsigns')

        local keymaps = require('core.keymaps')
        local nmap = keymaps.nmap

        local usercmds = require('plugins.integrations.usercmd')
        local getStatusUpdateEvent = usercmds.event_types.GitStatusUpdate

        local function fireGitStatusEvent()
            usercmds.fire(getStatusUpdateEvent)
        end

        local evnmap = require('plugins.integrations.eventmap').nmap(nil, fireGitStatusEvent)
        local vmap = require('plugins.integrations.eventmap').vmap(nil, fireGitStatusEvent)

        -- Navigation
        nmap('<leader>ghn', function()
            if vim.wo.diff then
                return '<leader>gh'
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return '<Ignore>'
        end, 'Next hunk', { expr = true })

        nmap('<leader>ghp', function()
            if vim.wo.diff then
                return '<leader>gH'
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return '<Ignore>'
        end, 'Previous hunk', { expr = true })

        -- Hunk
        --
        evnmap('<leader>ghs', gs.stage_hunk, 'Stage hunk')
        evnmap('<leader>ghr', gs.reset_hunk, 'Reset hunk')
        evnmap('<leader>ghu', gs.undo_stage_hunk, 'Undo stage hunk')
        evnmap('<leader>ghk', gs.preview_hunk, 'Preview hunk')

        vmap('<leader>ghs', function()
            gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Stage hunk')

        vmap('<leader>ghr', function()
            gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Reset hunk')

        -- Buffer
        evnmap('<leader>gS', gs.stage_buffer, 'Stage buffer')
        evnmap('<leader>gR', gs.reset_buffer, 'Reset buffer')

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

        nmap('<leader>gd', gs.diffthis, 'Diff index')
        nmap('<leader>gD', function()
            gs.diffthis('~0')
        end, 'Diff commit ~0')

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
