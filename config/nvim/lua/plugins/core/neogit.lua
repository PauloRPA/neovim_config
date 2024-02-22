return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim', -- optional - Diff integration
    },
    config = function()
        local neogit = require('neogit')
        local eventNmap = require('plugins.integrations.eventmap').nmap(nil, function()
            local windowDispositionPersistenceEvent = require('plugins.integrations.metaev').types
            .WindowDispositionPersistence
            require('plugins.integrations.usercmd').fire(windowDispositionPersistenceEvent)
        end)

        eventNmap('<leader>go', neogit.open, 'Open Neogit')

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
