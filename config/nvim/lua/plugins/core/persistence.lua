return {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    init = function()
        local persistence = require('persistence')
        local nmap = require('core.keymaps').nmap

        nmap('<leader>ql', function()
            persistence.load({ last = true })
        end, 'Restore last session')
        nmap('<leader>qd', persistence.load, 'Restore the session for the current directory')

        -- Integrations
        local cmds = require('plugins.integrations.usercmd')
        local ev = require('plugins.integrations.metaev').types
        cmds.addListener(ev.LoadSession, function()
            persistence.load({ last = true })
        end)
    end,

    config = function()
        local persistence = require('persistence')
        local nmap = require('core.keymaps').nmap

        persistence.setup({})

        nmap('<leader>qx', persistence.stop, 'Session wont be saved on exit')
    end
}
