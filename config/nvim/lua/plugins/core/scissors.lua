return {
    'chrisgrieser/nvim-scissors',
    dependencies = 'nvim-telescope/telescope.nvim',
    config = function()
        local scissors = require('scissors')
        local nmap = require('core.keymaps').nmap
        local vmap = require('core.keymaps').vmap
        local smap = require('core.keymaps').smap

        nmap('<leader>ase', scissors.editSnippet, 'Edit snippet')
        nmap('<leader>asa', scissors.addNewSnippet, 'Add new snippet')
        vmap('<leader>asa', scissors.addNewSnippet, 'Add new snippet')
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
                    insertNextToken = '<C-n>',            -- insert & normal mode
                    jumpBetweenBodyAndPrefix = '<C-Tab>', -- insert & normal mode
                },
            },
            snippetDir = vim.fn.stdpath('config') .. '/lua/snippets',
        })
    end,
}
