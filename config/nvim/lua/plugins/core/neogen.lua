return {
    'danymat/neogen',
    version = '*',
    config = function()
        local neogen = require('neogen')
        local nmap = require('core.keymaps').nmap
        nmap('<leader>an', neogen.generate, 'Generate annotations for the current function/class')

        neogen.setup({
            snippet_engine = 'luasnip',
        })
    end,
}
