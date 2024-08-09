return {
    'chrisgrieser/nvim-scissors',
    dependencies = 'nvim-telescope/telescope.nvim',
    config = function()
        local scissors = require('scissors')
        local nmap = require('core.keymaps').nmap
        local nvmap = require('core.keymaps').multi('nv')
        local smap = require('core.keymaps').smap

        nmap('<leader>ase', scissors.editSnippet, 'Edit snippet')
        nvmap('<leader>asa', scissors.addNewSnippet, 'Add new snippet')
        smap('<A-p>', 's<BS><C-o>P', 'Paste content')

        scissors.setup({
            editSnippetPopup = {
                keymaps = {
                    cancel = 'q',
                    saveChanges = '<CR>', -- alternatively, can also use `:w`
                    goBackToSearch = '<BS>',
                    deleteSnippet = '<C-d>',
                    duplicateSnippet = '<C-c>',
                    openInFile = '<C-o>',
                    insertNextPlaceholder = '<C-n>', -- insert & normal mode
                },
            },
            snippetDir = vim.fn.stdpath('config') .. '/lua/snippets',
        })
    end,
}
