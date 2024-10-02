return {
    'neovim/nvim-lspconfig',
    config = function()
        local lspconfig = require('lspconfig')
        local info = require('lsp.servers.info')
        local lsp_run = require('lsp.lsp_run')

        local lspSetups = info.lsp_server_settings()

        lsp_run.before()
        for serverName, setupConfig in pairs(lspSetups) do
            setupConfig.on_attach = function()
                require('lsp.keymaps').attachLspKeymapsToBuf()
                lsp_run.on_attach()
            end
            setupConfig.capabilities = require('lsp.servers.info').get_lsp_capabilities()

            lspconfig[serverName].setup(setupConfig)
        end
        lsp_run.after()
    end,
}
