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
end

return M
