return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-frecency.nvim', version = '*' },
    },
    config = function()
        local keymaps = require('core.keymaps')
        local nmap = keymaps.nmap

        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')

        local function open_multiple(prompt_bufnr)
            local picker = action_state.get_current_picker(prompt_bufnr)
            local num_selections = #picker:get_multi_selection()

            if num_selections > 1 then
                for _, entry in ipairs(picker:get_multi_selection()) do
                    vim.cmd(string.format('%s %s', ':e!', entry.filename))
                end
                vim.cmd('stopinsert')
            else
                actions.file_edit(prompt_bufnr)
            end
        end

        nmap('<leader>f', builtin.find_files, 'Search files in cwd')
        nmap('<A-F>', builtin.find_files, 'Search files in cwd')
        nmap('<leader><leader>', builtin.resume, 'Resume telescope')
        nmap('<leader>sk', builtin.keymaps, 'Search open keymaps')
        nmap('<leader>sa', builtin.buffers, 'Search open buffers')
        nmap('<A-A>', builtin.buffers, 'Search open buffers')
        nmap('<leader>sf', builtin.git_files, 'Search git files')
        nmap('<leader>sh', builtin.help_tags, 'Search help tags')
        nmap('<leader>so', builtin.oldfiles, 'Search old files')
        nmap('<leader>sm', builtin.man_pages, 'Search man pages')
        nmap('<leader>ss', builtin.live_grep, 'Live grep on cwd (respects .gitignore)')
        nmap('<A-S>', builtin.live_grep, 'Live grep on cwd (respects .gitignore)')
        nmap('<leader>sw', builtin.grep_string, 'Grep word under the cursor')
        nmap('<leader>sc', builtin.commands, 'Lists available plugin/user commands')

        nmap(
            '<leader>sgc',
            builtin.git_commits,
            'List git commits [<CR> Checkout] [<C-r>[m - mixed, s - soft, h - hard] reset ]'
        )
        nmap('<leader>sgs', builtin.git_stash, 'List git stash [<CR> pop]')
        nmap('<leader>sgb', builtin.git_branches, 'List git branches [<CR> Checkout]')

        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = keymaps.fn.clearLine,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-p>'] = actions.preview_scrolling_up,
                        ['<C-n>'] = actions.preview_scrolling_down,
                        ['<C-d>'] = actions.results_scrolling_down,
                        ['<A-j>'] = actions.cycle_history_next,
                        ['<A-k>'] = actions.cycle_history_prev,
                        ['<C-o>'] = open_multiple,
                    },
                    n = {
                        ['<C-o>'] = actions.move_to_middle,
                        ['<C-p>'] = actions.preview_scrolling_up,
                        ['<C-n>'] = actions.preview_scrolling_down,
                        ['<C-u>'] = actions.results_scrolling_up,
                        ['<C-d>'] = actions.results_scrolling_down,
                        ['<A-j>'] = actions.cycle_history_next,
                        ['<A-k>'] = actions.cycle_history_prev,
                    },
                },
                history = {
                    limit = 500,
                },
            },
        })

        nmap('<Leader>sp', function()
            require('telescope').extensions.frecency.frecency({
                workspace = 'CWD',
            })
        end, 'Search history based on frecency')

        nmap('<A-P>', function()
            require('telescope').extensions.frecency.frecency({
                workspace = 'CWD',
            })
        end, 'Search history based on frecency')

        require('telescope').load_extension('frecency')
    end,
}
