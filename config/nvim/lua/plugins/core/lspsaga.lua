return {
    'nvimdev/lspsaga.nvim',
    init = function()
        local lsp_run = require('lsp.lsp_run')
        local lsp_info = require('lsp.info')
        local keymapsSaga = require('lsp.keymaps')
        lsp_run.add_on_attach(function()
            if lsp_info.saga_loaded() then
                keymapsSaga.attachLspSagaKeymapsToBuf()
            end
        end)
    end,
    config = function()
        require('lspsaga').setup({
            outline = {
                layout = 'float', -- float or normal default is normal when is float above options will ignored
            },
            code_action = {
                keys = {
                    exec = '<Space>',
                    quit = 'q',
                },
            },
            lightbulb = {
                enable = false, -- enable
                sign = false, -- show sign in status column
                virtual_text = true, -- show virtual text at the end of line
                debounce = 10, -- timer debounce
                sign_priority = 40, -- sign priority
            },
        })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons', -- optional
    },
}
