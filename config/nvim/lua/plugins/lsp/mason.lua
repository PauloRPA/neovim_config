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
        local info = require('lsp.info')
        local mason = require('mason')

        mason.setup({})

        masonLsp.setup({
            ensure_installed = info.ensure_installed_lsps(),
        })

        masonDap.setup({
            ensure_installed = info.ensure_installed_daps(),
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
