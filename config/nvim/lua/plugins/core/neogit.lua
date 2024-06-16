return {
    'NeogitOrg/neogit',
    -- HACK: The current neogit commit is broken. 29/05/24. Change later.
    commit = '3b6cb8484a3b171f2404ce296be405f4d658b427',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- HACK: The current diffview commit is broken. 29/05/24. Change later.
        { 'sindrets/diffview.nvim', commit = 'a18981d2456e567ebb245d5c71ff65be096eedfb' }, -- optional - Diff integration
    },
    config = function()
        local neogit = require('neogit')
        local eventNmap = require('plugins.integrations.eventmap').nmap(nil, function()
            local windowDispositionPersistenceEvent =
                require('plugins.integrations.metaev').types.WindowDispositionPersistence
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
