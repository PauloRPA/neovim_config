return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-frecency.nvim', version = '*' },
        { 'nvim-telescope/telescope-live-grep-args.nvim', version = '^1.0.0' },
    },
    config = function()
        local keymaps = require('core.keymaps')
        local nmap = keymaps.nmap
        local xmap = keymaps.xmap
        local telescope = require('telescope')

        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')
        local lga_actions = require('telescope-live-grep-args.actions')

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
        nmap('<leader>ss', telescope.extensions.live_grep_args.live_grep_args, 'Live grep on cwd (respects .gitignore)')
        nmap('<A-S>', builtin.live_grep, 'Live grep on cwd (respects .gitignore)')
        nmap('<leader>sc', builtin.commands, 'Lists available plugin/user commands')
        xmap('<leader>s', require("telescope-live-grep-args.shortcuts").grep_visual_selection, 'Grep visual selection')
        xmap('<A-f>', require("telescope-live-grep-args.shortcuts").grep_visual_selection, 'Grep visual selection')

        nmap(
            '<leader>sgc',
            builtin.git_commits,
            'List git commits [<CR> Checkout] [<C-r>[m - mixed, s - soft, h - hard] reset ]'
        )
        nmap('<leader>sgs', builtin.git_stash, 'List git stash [<CR> pop]')
        nmap('<leader>sgb', builtin.git_branches, 'List git branches [<CR> Checkout]')

        telescope.setup({
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
                }
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = false,
                    mappings = {
                        i = {
                            ['<A-l>'] = lga_actions.quote_prompt(),
                            ['<A-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
                        },
                    },
                }
            }
        })

        nmap('<Leader>sp', function()
            telescope.extensions.frecency.frecency({
                workspace = 'CWD',
            })
        end, 'Search history based on frecency')

        nmap('<A-P>', function()
            telescope.extensions.frecency.frecency({
                workspace = 'CWD',
            })
        end, 'Search history based on frecency')

        telescope.load_extension('frecency')
        telescope.load_extension('live_grep_args')
    end,
}
