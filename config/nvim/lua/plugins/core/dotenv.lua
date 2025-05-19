return {
    'tpope/vim-dotenv',
    init = function()
        local env_custom = vim.api.nvim_create_augroup('env_custom', { clear = true })
        local project_dir = require('core.info').get_project_dir()

        vim.api.nvim_create_autocmd('User', {
            pattern = { 'RooterChDir' },
            callback = function()
                vim.fn.mkdir(project_dir, 'p')
                vim.cmd('Dotenv ' .. project_dir)
            end,
            desc = 'Rooter .env load',
            group = env_custom,
        })

        vim.api.nvim_create_autocmd('BufWritePost', {
            pattern = { '.env' },
            callback = function()
                vim.schedule(function()
                    vim.cmd('verbose Dotenv ' .. project_dir)
                end)
            end,
            desc = '.env load',
            group = env_custom,
        })
    end,
    config = function()
        local project_dir = require('core.info').get_project_dir()
        vim.fn.mkdir(project_dir, 'p')
        vim.schedule(function ()
            vim.cmd('Dotenv ' .. project_dir)
        end)
        local nmap = require('core.keymaps').nmap
        nmap('<leader>ov', '<cmd>e ' .. project_dir .. '/.env<CR>', 'Edit .env file for the current project')
    end
}
