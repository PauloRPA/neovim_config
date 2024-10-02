local jdtls = require('jdtls')
local lsp_keymaps = require('lsp.keymaps')
local dap_keymaps = require('dap.keymaps')
local lsp_info = require('lsp.servers.info')
local lsp_java = require('lsp.java_setup')

local config, features = lsp_java.config()

if features.lsp then
    lsp_keymaps.attachLspKeymapsToBuf()
    lsp_java.attachLspKeymapsToBuf()
end

if features.dap then
    dap_keymaps.attachDapKeymapsToBuf()
    lsp_java.attachDapKeymapsToBuf()
end

if features.javatest then
    lsp_java.attachTestKeymapsToBuf()
end

if lsp_info.saga_loaded() then
    lsp_keymaps.attachLspSagaKeymapsToBuf()
end

if config ~= nil then
    jdtls.start_or_attach(config)
end
