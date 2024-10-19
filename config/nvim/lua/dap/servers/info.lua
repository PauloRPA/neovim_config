local M = {}

local info = require('core.info')
local DAP_CONFIG_PATH = info.path_dap_servers_config
local DAP_CONFIG_MODULE = 'dap.servers.config.'
local ADDITIONAL_DAP_TO_INSTALL = { 'javadbg', 'javatest' }

local definitions = { 'firefox' }

M.ensure_installed_daps = function()
    local servers = vim.fn.copy(definitions)
    for _, currentFile in pairs(vim.fn.readdir(DAP_CONFIG_PATH)) do
        table.insert(servers, vim.fn.fnamemodify(currentFile, ':t:r'))
    end
    servers = vim.fn.extend(servers, ADDITIONAL_DAP_TO_INSTALL)
    return servers
end

M.dap_server_settings = function()
    local handlers = {}
    for _, currentFile in pairs(vim.fn.readdir(DAP_CONFIG_PATH)) do
        currentFile = vim.fn.fnamemodify(currentFile, ':t:r')
        handlers[currentFile] = require(DAP_CONFIG_MODULE .. currentFile)
    end
    return handlers
end

return M
