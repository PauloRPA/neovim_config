return {
    'nat-418/boole.nvim',
    opts = {
        mappings = {
            increment = '<C-a>',
            decrement = '<C-x>',
        },
        additions = {
            { 'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dec' },
            { 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom' },
            { 'ERROR', 'WARN', 'INFO', 'DEBUG', 'TRACE' },
        },
        allow_caps_additions = {
            -- { 'enable', 'disable' },
            -- enable → disable
            -- Enable → Disable
            -- ENABLE → DISABLE
        },
    },
}
