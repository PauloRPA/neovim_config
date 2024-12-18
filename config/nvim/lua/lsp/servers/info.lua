local M = {}

local info = require('core.info')
local LSP_CONFIG_PATH = info.path_lsp_servers_config
local LSP_CONFIG_MODULE = 'lsp.servers.config.'

local ADDITIONAL_LSP_TO_INSTALL = { 'jdtls' }
local definitions = {
    'cssls',
    'html',
    'jsonls',
    'lemminx',
    'markdown_oxide',
    'pylsp',
}

M.ensure_installed_lsps = function()
    local servers = vim.fn.copy(definitions)
    for _, currentFile in pairs(vim.fn.readdir(LSP_CONFIG_PATH)) do
        table.insert(servers, vim.fn.fnamemodify(currentFile, ':t:r'))
    end
    servers = vim.fn.extend(servers, ADDITIONAL_LSP_TO_INSTALL)
    return servers
end

M.lsp_server_settings = function()
    local handlers = {}
    for _, currentFile in pairs(vim.fn.readdir(LSP_CONFIG_PATH)) do
        currentFile = vim.fn.fnamemodify(currentFile, ':t:r')
        handlers[currentFile] = require(LSP_CONFIG_MODULE .. currentFile)
    end

    for _, definition in ipairs(definitions) do
        handlers[definition] = {}
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

M.definitions = function()
    return definitions
end

return M
