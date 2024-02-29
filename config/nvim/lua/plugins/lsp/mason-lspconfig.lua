return {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        'williamboman/mason.nvim',
        'neovim/nvim-lspconfig',
    },
    config = function()
        local masonLsp = require('mason-lspconfig')
        local info = require('lsp.info')

        masonLsp.setup({
            ensure_installed = info.get_configured_servers_name(),
        })
    end,
}
