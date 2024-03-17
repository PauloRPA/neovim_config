local jdtls = require('jdtls')
local lsp = require('lsp.keymaps')
local lsp_java = require('lsp.java')

local config = lsp_java.config()

lsp_java.attachLspKeymapsToBuf()
lsp.attachLspKeymapsToBuf()

if config ~= nil then
    jdtls.start_or_attach(config)
end
