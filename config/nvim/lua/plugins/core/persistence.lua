return {
    'folke/persistence.nvim',
    -- event = 'BufReadPre',
    event = 'VimEnter',
    config = function()
        local persistence = require('persistence')
        local nmap = require('core.keymaps').nmap

        persistence.setup({})

        nmap('<leader>qd', function()
            persistence.load({ last = true })
        end, 'Restore last session')
        nmap('<leader>ql', persistence.load, 'Restore the session for the current directory')
        nmap('<leader>qx', persistence.stop, 'Session wont be saved on exit')
    end,
}
