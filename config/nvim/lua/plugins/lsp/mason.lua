return {
    'williamboman/mason.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
        'mfussenegger/nvim-dap',

        'jay-babu/mason-nvim-dap.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    config = function()
        local masonLsp = require('mason-lspconfig')
        local masonDap = require('mason-nvim-dap')
        local lsp_server = require('lsp.servers.info')
        local dap_server = require('dap.servers.info')
        local mason = require('mason')

        mason.setup({})

        masonLsp.setup({
            ensure_installed = lsp_server.ensure_installed_lsps(),
        })

        masonDap.setup({
            ensure_installed = dap_server.ensure_installed_daps(),
            handlers = {
                function(config)
                    require('mason-nvim-dap').default_setup(config)
                end,
                javadbg = nil,
                javatest = nil,
            },
        })
    end,
}
