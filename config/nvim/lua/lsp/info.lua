M = {}

local configPath, _ = vim.fn.stdpath('config')

local TOOLING_PATH = configPath .. '/assets/tools'
local LSP_SETTINGS_PATH = '/lua/lsp/settings'
local LSP_SETTINGS_MODULE = 'lsp.settings.'
local ADDITIONAL_LSP_TO_INSTALL = { 'jdtls' }
local ADDITIONAL_DAP_TO_INSTALL = { 'javadbg', 'javatest' }

local function is_str_blank(str)
    return not str or str == ''
end

local function is_str_not_blank(str)
    return str and str ~= ''
end

M.is_str_not_blank = is_str_not_blank;
M.is_str_blank = is_str_blank

M.get_tool_path = function(tool)
    return vim.fn.glob(TOOLING_PATH .. '/*' .. tool .. '*')
end

M.has_tool = function(tool)
    return is_str_not_blank(vim.fn.glob(TOOLING_PATH .. '/*' .. tool .. '*'))
end

M.fetch = function()
    require('lsp.java')
end

M.get_tooling_path = function()
    return TOOLING_PATH
end

M.ensure_installed_lsps = function()
    local servers = {}
    for _, currentFile in pairs(vim.fn.readdir(configPath .. LSP_SETTINGS_PATH)) do
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

    for _, currentFile in pairs(vim.fn.readdir(configPath .. LSP_SETTINGS_PATH)) do
        currentFile = vim.fn.fnamemodify(currentFile, ':t:r')
        handlers[currentFile] = require(LSP_SETTINGS_MODULE .. currentFile)
    end

    return handlers
end

M.get_lsp_capabilities = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }
    return capabilities
end


return M
