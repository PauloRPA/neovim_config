return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local keymaps = require('core.keymaps')
        local nmap = keymaps.nmap

        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')

        nmap('<leader>f', builtin.find_files, 'Search files in cwd')
        nmap('<leader><leader>', builtin.buffers, 'Search open buffers')
        nmap('<leader>sf', builtin.git_files, 'Search git files')
        nmap('<leader>sh', builtin.help_tags, 'Search help tags')
        nmap('<leader>so', builtin.oldfiles, 'Search old files')
        nmap('<leader>sm', builtin.man_pages, 'Search man pages')
        nmap('<leader>ss', builtin.live_grep, 'Live grep on cwd (respects .gitignore)')
        nmap('<leader>sw', builtin.grep_string, 'Grep word under the cursor')
        nmap('<leader>sc', builtin.commands, 'Lists available plugin/user commands')

        nmap('<leader>sgc', builtin.git_commits,
            'List git commits [<CR> Checkout] [<C-r>[m - mixed, s - soft, h - hard] reset ]')
        nmap('<leader>sgs', builtin.git_stash, 'List git stash [<CR> pop]')
        nmap('<leader>sgb', builtin.git_branches, 'List git branches [<CR> Checkout]')

        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = keymaps.fn.clearLine,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-o>'] = actions.move_to_middle,
                        ['<C-p>'] = actions.preview_scrolling_up,
                        ['<C-n>'] = actions.preview_scrolling_down,
                        ['<C-d>'] = actions.results_scrolling_down,
                    },
                    n = {
                        ['<C-o>'] = actions.move_to_middle,
                        ['<C-p>'] = actions.preview_scrolling_up,
                        ['<C-n>'] = actions.preview_scrolling_down,
                        ['<C-u>'] = actions.results_scrolling_up,
                        ['<C-d>'] = actions.results_scrolling_down,
                    },
                }
            }

        })
    end
}
