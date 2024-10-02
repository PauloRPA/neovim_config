local M = {}

M.nvim_cache = vim.fn.stdpath('cache')
M.nvim_config = vim.fn.stdpath('config')
M.nvim_config_lua = M.nvim_config .. '/lua'

M.path_assets = M.nvim_config .. '/assets'
M.path_linters = M.path_assets .. '/lint'
M.path_tooling = M.path_assets .. '/tools'
M.path_skel_templates = M.path_assets .. '/templates'
M.path_snippets = M.nvim_config_lua .. '/snippets'

-- Dap
M.path_dap = M.nvim_config_lua .. '/dap'
M.path_dap_servers = M.path_dap .. '/servers'
M.path_dap_servers_config = M.path_dap_servers .. '/config'

-- Lsp
M.path_lsp = M.nvim_config_lua .. '/lsp'
M.path_lsp_servers = M.path_lsp .. '/servers'
M.path_lsp_servers_config = M.path_lsp_servers .. '/config'

--- Returns the full path to a tool
---@param tool string tool name
---@return string tool path
M.get_tool_path = function(tool)
    return vim.fn.glob(M.path_tooling .. '/*' .. tool .. '*')
end

--- Return whether a tool exists
---@param tool string tool name
---@return boolean True or False
M.has_tool = function(tool)
    return require('core.functions').is_str_not_blank(vim.fn.glob(M.path_tooling .. '/*' .. tool .. '*'))
end

return M
