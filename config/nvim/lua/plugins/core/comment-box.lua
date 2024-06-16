return {
    'LudoPinelli/comment-box.nvim',
    config = function()
        local nmap = require('core.keymaps').nmap
        local vmap = require('core.keymaps').vmap

        --        ╭─────────────────────────────────────────────────────────╮
        --        │                       Comment-Box                       │
        --        ╰─────────────────────────────────────────────────────────╯

        --  ───────────────────────────── Normal Mode ─────────────────────────────

        nmap('<leader>awb', '<Cmd>CBccbox<CR>', 'Wrap in a box')
        nmap('<leader>awl', '<Cmd>CBccline6<CR>', 'Wrap in a stylized line')
        nmap('<leader>awh', '<Cmd>CBllline6<CR>', 'Wrap in a stylized line left')
        nmap('<leader>awL', '<Cmd>CBline<CR>', 'Draw line')
        nmap('<leader>awd', '<Cmd>CBd<CR>', 'Remove box')

        --  ───────────────────────────── Visual mode ─────────────────────────────

        vmap('<leader>awb', '<Cmd>CBccbox<CR>', 'Wrap in a box')
        vmap('<leader>awl', '<Cmd>CBccline6<CR>', 'Wrap in a stylized line')
        vmap('<leader>awh', '<Cmd>CBllline6<CR>', 'Wrap in a stylized line left')
        vmap('<leader>awL', '<Cmd>CBline<CR>', 'Draw line')
        vmap('<leader>awd', '<Cmd>CBd<CR>', 'Remove box')

        -- ──────────────────────────────────────────────────────────────────────

        require('comment-box').setup({
            doc_width = 80, -- width of the document
            box_width = 60, -- width of the boxes
            line_width = 76, -- width of the lines
        })
    end,
}
