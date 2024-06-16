local M = {}

M.path_config = vim.fn.stdpath('config')
M.path_assets = M.path_config .. '/assets'
M.path_linters = M.path_assets .. '/lint'

return M
