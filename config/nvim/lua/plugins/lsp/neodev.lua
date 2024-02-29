return {
    'folke/neodev.nvim',
    init = function()
        require('neodev').setup({
            library = {
                enabled = true,  -- when not enabled, neodev will not change any settings to the LSP server
                runtime = true,  -- runtime path
                types = true,    -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
                plugins = true,  -- installed opt or start plugins in packpath
            },
            setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
            lspconfig = true,
            pathStrict = true,
        })
    end
}
