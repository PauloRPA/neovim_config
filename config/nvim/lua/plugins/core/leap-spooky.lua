return {
    'ggandor/leap-spooky.nvim',
    commit = '5f44a1f63dc1c4ce50244e92da5bc0d8d1f6eb47',
    dependencies = { 'ggandor/leap.nvim' },
    config = function()

        local imap = require('core.keymaps').imap
        local nmap = require('core.keymaps').nmap

        nmap('<A-v>', function()
            vim.api.nvim_input('vim')
        end, 'Visual inner leap content')

        nmap('<A-V>', function()
            vim.api.nvim_input('viM')
        end, 'Visual inner leap content from another window')

        nmap('<A-y>', function()
            vim.api.nvim_input('yir')
        end, 'Yank inner leap content')

        nmap('<A-Y>', function()
            vim.api.nvim_input('yiR')
        end, 'Yank inner leap content from another window')

        imap('<A-c>', function()
            vim.api.nvim_input('<C-o>cim')
        end, 'Cut inner leap content')

        imap('<A-C>', function()
            vim.api.nvim_input('<C-o>ciM')
        end, 'Cut inner leap content from another window')

        imap('<A-y>', function()
            vim.api.nvim_input('<C-o>yir')
        end, 'Yank inner leap content')

        imap('<A-Y>', function()
            vim.api.nvim_input('<C-o>yiR')
        end, 'Yank inner leap content from another window')

        imap('<A-p>', function()
            vim.api.nvim_input('<C-o>P')
        end, 'Paste leap content')

        require('leap-spooky').setup {
            -- Additional text objects, to be merged with the default ones.
            extra_text_objects = {'ia', 'aa', 'if', 'af', 'ad', 'id'},
            --  `yrr<leap>` and `ymm<leap>` will yank a line in the current window.
            affixes = {
                -- The cursor moves to the targeted object, and stays there.
                magnetic = { window = 'm', cross_window = 'M' },
                -- The operation is executed seemingly remotely (the cursor boomerangs
                -- back afterwards).
                remote = { window = 'r', cross_window = 'R' },
            },
            -- Defines text objects like `riw`, `raw`, etc., instead of
            -- targets.vim-style `irw`, `arw`. (Note: prefix is forced if a custom
            -- text object does not start with "a" or "i".)
            prefix = false,
            -- The yanked text will automatically be pasted at the cursor position
            -- if the unnamed register is in use.
            paste_on_remote_yank = false,
        }
    end
}
