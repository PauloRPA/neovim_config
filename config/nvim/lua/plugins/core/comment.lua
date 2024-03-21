return {
    'numToStr/Comment.nvim',
    config = function()
        -- Enable Comment.nvim
        local comment = require('Comment')
        local comment_api = require('Comment.api')
        local nmap = require('core.keymaps').nmap
        local xmap = require('core.keymaps').xmap
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

        nmap('<leader>/', comment_api.toggle.linewise.current, 'Comment a line')
        xmap('<leader>/', function()
            vim.api.nvim_feedkeys(esc, 'nx', false)
            comment_api.toggle.linewise(vim.fn.visualmode())
        end, 'Toggle comment on a block')

        comment.setup({
            padding = true,
            sticky = true,
            ignore = nil,
            toggler = {
                -- line = ' /',
                block = ' -',
            },
            opleader = {
                line = 'f[',
                block = ' -',
            },
            mappings = {
                basic = true,
                extra = false,
            },
            pre_hook = nil,
            post_hook = nil,

        })
    end
}
