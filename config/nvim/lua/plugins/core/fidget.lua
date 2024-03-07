return {
    'j-hui/fidget.nvim',
    tag = 'v1.4.0',
    opts = {
        progress = {
            poll_rate = 0,               -- How and when to poll for progress messages
            suppress_on_insert = true,   -- Suppress new messages while in insert mode
            ignore_done_already = true,  -- Ignore new tasks that are already complete
            ignore_empty_message = true, -- Ignore new tasks that don't contain a message
            clear_on_detach =            -- Clear notification group when LSP server detaches
                function(client_id)
                    local client = vim.lsp.get_client_by_id(client_id)
                    return client and client.name or nil
                end,
            notification_group = function(msg) return msg.lsp_client.name end,
            ignore = {}, -- List of LSP servers to ignore

            display = {
                done_icon = '',
                progress_icon = require('fidget').spinner.animate({ '', '󰪞', '󰪟', '󰪠', '󰪡', '󰪢', '󰪣', '󰪤', '󰪥', }, 1),
                progress_style = 'MoreMsg',
                group_style = 'Title',
                icon_style = 'Question',
                render_limit = 3,
            },
        },
    },
}
