return {
    'rcarriga/nvim-notify',
    dependencies = {
        { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
        vim.notify = require('notify')

        local nmap = require('core.keymaps').nmap
        nmap('<leader>sn', '<cmd>Telescope notify<CR>', 'Search notifications')

        require('notify').setup({
            stages = 'fade',
            render = 'compact',
            timeout = 800,
            max_width = 100,
        })
    end,
}
