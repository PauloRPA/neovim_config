return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = {'BufReadPre'},
    opts = {
        -- TODO: Create a keybind to open TODOS in a quickfix list or in telescope.
        signs = false,
        sign_priority = 8,
        -- TODO: TODO
        -- NOTE: NOTE
        -- HACK: HACK
        -- WARN: WARN
        -- FIX: FIX
        -- PERF: PERF
        -- TEST: TEST
        highlight = {
            comments_only = true, -- uses treesitter to match keywords in comments only
            exclude = {}, -- list of file types to exclude highlighting
        },
    }

}
