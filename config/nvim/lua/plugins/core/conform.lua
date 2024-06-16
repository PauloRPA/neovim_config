return {
    'stevearc/conform.nvim',
    config = function()
        local conform = require('conform')
        local nmap = require('core.keymaps').nmap

        nmap('<leader>aF', function()
            conform.format({ bufnr = 0, async = true }, function(_, did_edit)
                if did_edit then
                    vim.cmd.w()
                end
            end)
        end, 'Format current buffer with Conform')

        local formatters = {
            lua = { 'stylua' },
            -- java = { 'google-java-format' },
        }

        conform.setup({
            formatters_by_ft = formatters,
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
                        vim.cmd.w()
                    end
                end)
            end,
            group = conform_group,
        })

        local mtool = require('plugins.mason_tool_list')

        for _, formatter in pairs(formatters) do
            mtool.addTools(formatter)
        end
    end,
}
