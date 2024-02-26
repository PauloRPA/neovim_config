return {
    'airblade/vim-rooter',
    config = function()
        local nmap = require('core.keymaps').nmap

        local rooter = {
            rooter_patterns = { '.git', 'pom.xml', 'resourcepacks', 'Makefile' },
            rooter_silent_chdir = 1,
        }

        for variable, value in pairs(rooter) do
            vim.api.nvim_set_var(variable, value)
        end
    end,
}
