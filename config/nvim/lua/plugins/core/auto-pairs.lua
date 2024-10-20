return {
    'windwp/nvim-autopairs',
    enabled = true,
    config = function()
        require('nvim-autopairs').setup({
            map_c_h = false,
            map_c_w = false,
            map_cr = false,
            map_bs = false,
            disable_in_macro = true,
            disable_in_visualblock = true,
        })
        require('nvim-autopairs').clear_rules()
        local Rule = require('nvim-autopairs.rule')
        local npairs = require('nvim-autopairs')

        npairs.add_rule(Rule('(', ')'))
    end,
}
