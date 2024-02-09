return {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    config = function()
        local persistence = require('persistence')
        local nmap = require('core.keymaps').nmap

        persistence.setup({})

        nmap('<leader>ql', function()
            require('persistence').load({ last = true })
        end, 'Restore last session')

        nmap('<leader>qd', persistence.load, 'Restore the session for the current directory')
        nmap('<leader>qx', persistence.stop, 'Session wont be saved on exit')
    end
}
