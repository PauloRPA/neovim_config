local M = {}

local user_au = vim.api.nvim_create_augroup("user_au", { clear = true })

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
        "BufEnter",
    }, {
        pattern = { '*.css' },
        callback = function()
            vim.opt.formatoptions:remove('c')
            vim.opt.formatoptions:remove('r')
            vim.opt.formatoptions:remove('o')
        end,
        desc = "",
        once = true,
        group = user_au,
    })

    -- [[ Highlight on yank ]] :help vim.highlight.on_yank()
    vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
            vim.highlight.on_yank()
        end,
        group = user_au,
        pattern = '*',
    })
end

return M
