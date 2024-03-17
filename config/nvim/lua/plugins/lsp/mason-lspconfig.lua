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
            ensure_installed = info.ensure_installed_servers_name(),
        })
    end,
}
