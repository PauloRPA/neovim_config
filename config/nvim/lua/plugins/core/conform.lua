return {
    'stevearc/conform.nvim',
    config = function()
        local conform = require('conform')

        local formatters = {
            -- java = { 'google-java-format', },
            -- javascript = { 'prettierd', 'prettier', lsp_format = 'fallback', stop_after_first = true },
            lua = { 'stylua', lsp_format = 'fallback' },
        }

        conform.setup({
            formatters_by_ft = formatters,
            default_format_opts = {
                lsp_format = 'fallback',
            },
        })

        conform.formatters['google-java-format'] = {
            args = {
                '-a',
                '--skip-sorting-imports',
                '--skip-removing-unused-imports',
                '$FILENAME',
            },
        }

        local conform_group = vim.api.nvim_create_augroup('nvim-conform-custom', { clear = true })
        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            callback = function(args)
                conform.format({ bufnr = args.buf, async = true }, function(_, did_edit)
                    if did_edit then
                        vim.cmd.wa()
                    end
                end)
            end,
            group = conform_group,
        })

        local mtool = require('plugins.mason_tool_list')
        for _, formatter in pairs(formatters) do
            if type(formatter) == 'table' then
                mtool.addTools(formatter)
            end
        end
    end,
}
