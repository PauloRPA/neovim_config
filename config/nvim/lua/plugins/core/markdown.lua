return {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        local mkdn = vim.api.nvim_create_augroup('markdown-docs.view', { clear = true })

        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'nvim-docs-view' },
            callback = function()
                vim.cmd.setl('ft=markdown')
            end,
            desc = 'Treat docs-view to md files',
            once = true,
            group = mkdn,
        })

        require('render-markdown').setup({
            headings = { '󰽢 ', ' ', ' ', ' ', ' ', ' ' },
            file_types = { 'markdown' },
            checkbox = {
                unchecked = ' ',
                checked = ' ',
            },
        })
    end,
}
