return {
    'neovim/nvim-lspconfig',
    config = function()
        local lspconfig = require('lspconfig')
        local info = require('lsp.info')

        local lspSetups = info.get_configured_lspconfigs()

        for serverName, setupConfig in pairs(lspSetups) do
            setupConfig.on_attach = function()
                require('lsp.keymaps').attachLspKeymapsToBuf()
            end
            setupConfig.capabilities = require('lsp.info').get_lsp_capabilities()

            lspconfig[serverName].setup(setupConfig)
        end
    end,
}
