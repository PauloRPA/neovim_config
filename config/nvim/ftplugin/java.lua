local jdtls = require('jdtls')
local lsp_keymaps = require('lsp.keymaps')
local lsp_java = require('lsp.java')

local config, features = lsp_java.config()

if features.lsp then
    lsp_keymaps.attachLspKeymapsToBuf()
    lsp_java.attachLspKeymapsToBuf()
end

if features.dap then
    lsp_keymaps.attachDapKeymapsToBuf()
    lsp_java.attachDapKeymapsToBuf()
end

if features.javatest then
    lsp_java.attachTestKeymapsToBuf()
end


if config ~= nil then
    jdtls.start_or_attach(config)
end
