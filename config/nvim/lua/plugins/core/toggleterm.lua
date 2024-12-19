return {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
        local Terminal = require('toggleterm.terminal').Terminal
        local nmap = require('core.keymaps').nmap

        local eventNmap = require('core.keymaps').nevmap(nil, function()
            local windowDispositionPersistenceEvent =
                require('plugins.integrations.metaev').types.WindowDispositionPersistence
            require('plugins.integrations.usercmd').fire(windowDispositionPersistenceEvent)
        end)

        local tmap = require('core.keymaps').tmap
        local toggleterm = require('toggleterm')

        local bottom = Terminal:new({
            direction = 'horizontal', -- the layout for the terminal, same as the main config options
            close_on_exit = true,
            auto_scroll = true, -- automatically scroll to the bottom on terminal output
            count = 1,
        })

        local float = Terminal:new({
            direction = 'float', -- the layout for the terminal, same as the main config options
            float_opts = {
                border = 'curved',
            },
            close_on_exit = true,
            auto_scroll = true, -- automatically scroll to the bottom on terminal output
            count = 2,
        })

        eventNmap('<A-1>', function()
            bottom:toggle()
        end, 'Open/close terminal at the bottom of the screen')

        nmap('<A-0>', function()
            float:toggle()
        end, 'Open a floating terminal')

        tmap('<A-1>', function()
            bottom:toggle()
        end, 'Open/close terminal at the bottom of the screen')

        tmap('<A-0>', function()
            float:toggle()
        end, 'Open a floating terminal')

        tmap('<C-j>', [[<Cmd>wincmd j<CR>]], 'Select bottom pane')
        tmap('<C-k>', [[<Cmd>wincmd k<CR>]], 'Select top pane')
        tmap('<C-r>', function()
            local clipboard = vim.fn.getreg('0')
            vim.api.nvim_feedkeys(clipboard, 'n', false)
        end, 'Paste clipboard content')

        toggleterm.setup({
            size = 10,
            autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
            start_in_insert = false,
        })
    end,
}
