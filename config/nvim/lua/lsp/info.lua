M = {}

local LSP_SETTINGS_PATH = '/lua/lsp/settings'
local LSP_SETTINGS_MODULE = 'lsp.settings.'

local configPath, _ = vim.fn.stdpath('config')

M.get_configured_servers_name = function()
    local servers = {}
    for _, currentFile in pairs(vim.fn.readdir(configPath .. LSP_SETTINGS_PATH)) do
        table.insert(servers, vim.fn.fnamemodify(currentFile, ':t:r'))
    end
    return servers
end

M.get_configured_lspconfigs = function()
    local handlers = {}

    for _, currentFile in pairs(vim.fn.readdir(configPath .. LSP_SETTINGS_PATH)) do
        currentFile = vim.fn.fnamemodify(currentFile, ':t:r')
        handlers[currentFile] = require(LSP_SETTINGS_MODULE .. currentFile)
    end

    return handlers
end

M.get_lsp_capabilities = function()
    return require('cmp_nvim_lsp').default_capabilities()
end


return M
