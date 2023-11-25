local M = {}

local user_au = vim.api.nvim_create_augroup("user_au", { clear = true })

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
end

return M
