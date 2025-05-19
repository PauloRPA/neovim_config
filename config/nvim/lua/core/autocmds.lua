local M = {}

local nmap = require('core.keymaps').nmap
local user_au = vim.api.nvim_create_augroup('user_au', { clear = true })

-- vim.api.nvim_create_autocmd({
--     "",
-- }, {
--     pattern = { "" },
--     callback = function()
--
--     end,
--     desc = "",
--     once = false,
--     group = { "user_au" },
-- })

M.load = function()
    vim.api.nvim_create_autocmd({
        'BufEnter',
    }, {
        pattern = { '*.css' },
        callback = function()
            vim.opt.formatoptions:remove('c')
            vim.opt.formatoptions:remove('r')
            vim.opt.formatoptions:remove('o')
        end,
        desc = '',
        once = true,
        group = user_au,
    })

    -- [[ Highlight on yank ]] :help vim.highlight.on_yank()
    vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
            vim.highlight.on_yank({
                higroup = 'Search',
                timeout = 150,
                on_macro = false,
                on_visual = true,
                event = vim.api.nvim_get_vvar('event'),
            })
        end,
        group = user_au,
        pattern = '*',
    })

    vim.api.nvim_create_autocmd('FileType', {
        callback = function()
            nmap('q', '<C-w>c', 'Close window', { buffer = 0 })
        end,
        group = user_au,
        pattern = {'notify', 'neotest-output'},
    })


end

return M
