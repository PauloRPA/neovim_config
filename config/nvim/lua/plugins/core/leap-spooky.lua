return {
    'ggandor/leap-spooky.nvim',
    dependencies = { 'ggandor/leap.nvim' },
    config = function()
        local nmap = require('core.keymaps').nmap
        local imap = require('core.keymaps').imap

        nmap('<A-y>', function()
            local keys = vim.api.nvim_replace_termcodes('yir', true, false, true)
            vim.api.nvim_feedkeys(keys, 'L', true) -- Unwrap content inside a parenthesis
        end, 'Yank inner leap content')

        nmap('<A-Y>', function()
            local keys = vim.api.nvim_replace_termcodes('yiR', true, false, true)
            vim.api.nvim_feedkeys(keys, 'L', true) -- Unwrap content inside a parenthesis
        end, 'Yank inner leap content from another window')

        imap('<A-y>', function()
            local keys = vim.api.nvim_replace_termcodes('<ESC>lyir"', true, false, true)
            vim.api.nvim_feedkeys(keys, 'L', true) -- Unwrap content inside a parenthesis
            vim.schedule(function()
                vim.cmd('startinsert')
            end)
        end, 'Yank inner leap content')

        imap('<A-Y>', function()
            local keys = vim.api.nvim_replace_termcodes('<ESC>lyiR"', true, false, true)
            vim.api.nvim_feedkeys(keys, 'L', true) -- Unwrap content inside a parenthesis
            vim.schedule(function()
                vim.cmd('startinsert')
            end)
        end, 'Yank  inner leap content from another window')

        imap('<A-m>', function()
            local keys = vim.api.nvim_replace_termcodes('<ESC>cirw', true, false, true)
            vim.api.nvim_feedkeys(keys, 'L', true) -- Unwrap content inside a parenthesis
        end, 'Cut inner leap content')

        imap('<A-M>', function()
            local keys = vim.api.nvim_replace_termcodes('<ESC>ciRw', true, false, true)
            vim.api.nvim_feedkeys(keys, 'L', true) -- Unwrap content inside a parenthesis
        end, 'Cut inner leap content from another window')

        nmap('<A-m>', function()
            local keys = vim.api.nvim_replace_termcodes('<ESC>cir', true, false, true)
            vim.api.nvim_feedkeys(keys, 'L', true) -- Unwrap content inside a parenthesis
        end, 'Cut inner leap content')

        nmap('<A-M>', function()
            local keys = vim.api.nvim_replace_termcodes('<ESC>ciR', true, false, true)
            vim.api.nvim_feedkeys(keys, 'L', true) -- Unwrap content inside a parenthesis
        end, 'Cut inner leap content from another window')

        require('leap-spooky').setup({
            -- Additional text objects, to be merged with the default ones.
            extra_text_objects = { 'ia', 'aa', 'if', 'af', 'ad', 'id' },
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
        })
    end,
}
