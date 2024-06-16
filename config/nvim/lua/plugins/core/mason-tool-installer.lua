return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
        'mfussenegger/nvim-lint',
        'stevearc/conform.nvim',
        'mfussenegger/nvim-dap',
        'williamboman/mason.nvim',
    },
    config = function()
        local mtool = require('mason-tool-installer')
        local tool_list = require('plugins.mason_tool_list').tools

        mtool.setup({
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
