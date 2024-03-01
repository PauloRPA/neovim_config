return {
    'Eandrju/cellular-automaton.nvim',
    config = function()
        local nmap = require('core.keymaps').nmap

        nmap('<leader>am', '<cmd>CellularAutomaton make_it_rain<CR>', 'Make it rain')
        nmap('<leader>aM', '<cmd>CellularAutomaton game_of_life<CR>', 'Game of file')
    end
}
