return {
    'szw/vim-maximizer',
    config = function()
        local nmap = require('core.keymaps').nmap

        nmap('<leader>m', '<cmd>MaximizerToggle<CR>', 'Maximize current window')
    end,
}
