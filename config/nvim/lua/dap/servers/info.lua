local M = {}

local info = require('core.info')
local DAP_CONFIG_PATH = info.path_dap_servers_config
local DAP_CONFIG_MODULE = 'dap.servers.config.'
local ADDITIONAL_DAP_TO_INSTALL = { 'javadbg', 'javatest' }
local dap_keymaps = require('dap.keymaps')

local default_setup = function(config)
    require('mason-nvim-dap').default_setup(config)
    dap_keymaps.attachDapKeymapsToBuf()
end

local definitions = {
    node2 = default_setup,
}

M.ensure_installed_daps = function()
    local servers = vim.fn.copy(vim.tbl_keys(definitions) or {})
    for _, currentFile in pairs(vim.fn.readdir(DAP_CONFIG_PATH)) do
        table.insert(servers, vim.fn.fnamemodify(currentFile, ':t:r'))
    end
    servers = vim.fn.extend(servers, ADDITIONAL_DAP_TO_INSTALL)
    return servers
end

-- Read DAP defintions from servers.config `:h mason-nvim-dap`
for _, currentFile in pairs(vim.fn.readdir(DAP_CONFIG_PATH)) do
    currentFile = vim.fn.fnamemodify(currentFile, ':t:r')
    definitions[currentFile] = require(DAP_CONFIG_MODULE .. currentFile)
end

M.handlers = definitions

return M
