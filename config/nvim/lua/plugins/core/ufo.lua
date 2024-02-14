return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()

        -- Mappings
        local nmap = require('core.keymaps').nmap

        nmap('z*', require('ufo').openAllFolds, 'Open all folds')
        nmap('z/', require('ufo').closeAllFolds, 'Close all folds')

        -- Nvim config
        vim.o.foldcolumn = '0'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- NOTE: Reserved for future use. It selects between peeking folded content and LSP hover.
        local function peekOrHover()
            local winid = require('ufo').peekFoldedLinesUnderCursor()
            if winid then
                local bufnr = vim.api.nvim_win_get_buf(winid)
                local keys = { 'a', 'i', 'o', 'A', 'I', 'O', 'gd', 'gr' }
                for _, k in ipairs(keys) do
                    vim.keymap.set('n', k, '<CR>' .. k, { noremap = false, buffer = bufnr })
                end
            else
                vim.lsp.buf.hover()
            end
        end

        nmap('K', peekOrHover, 'Hover Documentation / Peek fold')

        -- WARN: When adding LSPs to the configuration, adjustments will be needed.
        require('ufo').setup({
            close_fold_kinds = {'imports', 'comment'},
            provider_selector = function(bufnr, filetype, buftype)
                return {'treesitter', 'indent'}
            end,
            preview = {
                mappings = {
                    scrollU = '<C-p>',
                    scrollD = '<C-n>',
                    jumpTop = '[',
                    jumpBot = ']',
                }
            },
        })
    end,
}
