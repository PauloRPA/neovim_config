return {
    'williamboman/mason.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
        'mfussenegger/nvim-dap',

        'jay-babu/mason-nvim-dap.nvim',
        'williamboman/mason-lspconfig.nvim',
        {
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            dependencies = {
                'mfussenegger/nvim-lint',
                'stevearc/conform.nvim',
                'mfussenegger/nvim-dap',
                'williamboman/mason.nvim',
            },
        },
    },
    config = function()
        local mason = require('mason')
        local masonLsp = require('mason-lspconfig')
        local masonDap = require('mason-nvim-dap')
        local masonTools = require('mason-tool-installer')

        local lsp_server = require('lsp.servers.info')
        local dap_server = require('dap.servers.info')
        local tool_list = require('plugins.mason_tool_list').tools

        mason.setup({})

        masonLsp.setup({
            ensure_installed = lsp_server.ensure_installed_lsps(),
        })

        local handlers = {
            function(config)
                require('core.editor').set_debug_line()
            end,
            javadbg = nil,
            javatest = nil,
        }
        handlers = vim.tbl_extend('keep', handlers, dap_server.handlers)

        masonDap.setup({
            ensure_installed = dap_server.ensure_installed_daps(),
            handlers = handlers,
        })

        masonTools.setup({
            ensure_installed = tool_list,

            run_on_start = true,
            start_delay = 3000, -- 3 second delay

            auto_update = false,

            integrations = {
                ['mason-lspconfig'] = true,
                ['mason-null-ls'] = true,
                ['mason-nvim-dap'] = true,
            },
        })
    end,
}
