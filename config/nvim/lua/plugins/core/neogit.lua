return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'sindrets/diffview.nvim',
            config = function()
                local nmap = require('core.keymaps').nmap

                local diffview = vim.api.nvim_create_augroup('diffview', { clear = true })
                vim.api.nvim_create_autocmd({ 'FileType' }, {
                    pattern = { 'DiffviewFiles' },
                    callback = function()
                        nmap(
                            'q',
                            '<cmd>DiffviewClose<CR>',
                            'Close Diffview',
                            { noremap = true, silent = true, buffer = 0 }
                        )
                    end,
                    group = diffview,
                })

                require('diffview').setup({})
            end,
        },
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
