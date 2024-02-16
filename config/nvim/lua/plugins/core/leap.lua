return {
    'ggandor/leap.nvim',
    config = function()
        local leap = require('leap')
        local nmap = require('core.keymaps').nmap

        nmap('<A-s>', '<Plug>(leap-forward)', 'Leap forward')
        nmap('<A-a>', '<Plug>(leap-backward)', 'Leap backward')

        require('leap.user').set_repeat_keys('<cr>', '<bs>', {
            relative_directions = true,
            modes = {'n', 'x', 'o'},
        })

    end,
}
