return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim',         -- required
        'sindrets/diffview.nvim',        -- optional - Diff integration
    },
    config = function()
        local neogit = require('neogit')
        local nmap = require('core.keymaps').nmap

        nmap('<leader>go', neogit.open, 'Open Neogit')

        neogit.setup({
            kind = 'split_above',
            commit_editor = {
                kind = 'split_above',
            },
            commit_view = {
                kind = 'split_above',
                verify_commit = os.execute('which gpg') == 0, -- Can be set to true or false, otherwise we try to find the binary
            },
        })
    end,
}
