return {
    'amrbashir/nvim-docs-view',
    lazy = true,
    cmd = 'DocsViewToggle',
    opts = {
        position = 'right',
        width = 60,
    },
    init = function()
        local nmap = require('core.keymaps').nmap

        nmap('<leader>ad', '<cmd>DocsViewToggle<CR>', 'Open docs in a separate pane')
    end,
}
