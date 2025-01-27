return {
    'airblade/vim-rooter',
    config = function()
        local rooter = {
            rooter_patterns = { '.git', 'pom.xml', 'resourcepacks', 'Makefile', 'init.lua', 'Memo.md', 'Index.md' },
            rooter_silent_chdir = 1,
        }

        for variable, value in pairs(rooter) do
            vim.api.nvim_set_var(variable, value)
        end
    end,
}
