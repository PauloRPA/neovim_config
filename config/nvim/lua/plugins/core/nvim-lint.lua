return {
    'mfussenegger/nvim-lint',
    config = function()
        local lint = require('lint')
        lint.linters_by_ft = {
            -- java = { 'checkstyle' },
        }

        -- TODO: The user should be able to configure the linter per project
        lint.linters.checkstyle.args = {
            '-c',
            function()
                return require('core.info').path_linters .. '/java/checkstyle/custom_google_checks.xml'
            end,
        }

        local lint_group = vim.api.nvim_create_augroup('nvim-lint-custom', { clear = true })
        vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost' }, {
            callback = function()
                require('lint').try_lint()
            end,
            group = lint_group,
        })

        local tool_list = require('plugins.mason_tool_list')
        tool_list.addTools({ 'checkstyle' })
    end,
}
