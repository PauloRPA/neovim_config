M = {}

local info = require('core.info')

local LSP_SETTINGS_PATH = info.path_lsp_servers
local LSP_SETTINGS_MODULE = 'lsp.servers.'
local ADDITIONAL_LSP_TO_INSTALL = { 'jdtls' }
local ADDITIONAL_DAP_TO_INSTALL = { 'javadbg', 'javatest' }

M.init = function()
    require('lsp.java')
end

M.ensure_installed_lsps = function()
    local servers = {}
    for _, currentFile in pairs(vim.fn.readdir(LSP_SETTINGS_PATH)) do
        table.insert(servers, vim.fn.fnamemodify(currentFile, ':t:r'))
    end
    servers = vim.fn.extend(servers, ADDITIONAL_LSP_TO_INSTALL)
    return servers
end

M.ensure_installed_daps = function()
    local servers = {}
    servers = vim.fn.extend(servers, ADDITIONAL_DAP_TO_INSTALL)
    return servers
end

M.get_configured_lspconfigs = function()
    local handlers = {}

    for _, currentFile in pairs(vim.fn.readdir(LSP_SETTINGS_PATH)) do
        currentFile = vim.fn.fnamemodify(currentFile, ':t:r')
        handlers[currentFile] = require(LSP_SETTINGS_MODULE .. currentFile)
    end

    return handlers
end

M.get_lsp_capabilities = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    return capabilities
end

M.saga_loaded = function()
    local lspsaga = require('lazy.core.config').plugins['lspsaga.nvim']
    return lspsaga and true or false
end

return M
