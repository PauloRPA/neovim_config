return {
    'LudoPinelli/comment-box.nvim',
    config = function()
        local nvmap = require('core.keymaps').multi('nv')

        --        ╭─────────────────────────────────────────────────────────╮
        --        │                       Comment-Box                       │
        --        ╰─────────────────────────────────────────────────────────╯

        --  ───────────────────────────── Normal Visual mode ─────────────────────────────

        nvmap('<leader>awb', '<Cmd>CBccbox<CR>', 'Wrap in a box')
        nvmap('<leader>awl', '<Cmd>CBccline6<CR>', 'Wrap in a stylized line')
        nvmap('<leader>awh', '<Cmd>CBllline6<CR>', 'Wrap in a stylized line left')
        nvmap('<leader>awL', '<Cmd>CBline<CR>', 'Draw line')
        nvmap('<leader>awd', '<Cmd>CBd<CR>', 'Remove box')

        -- ──────────────────────────────────────────────────────────────────────

        require('comment-box').setup({
            doc_width = 80, -- width of the document
            box_width = 60, -- width of the boxes
            line_width = 76, -- width of the lines
        })
    end,
}
