return {
    'stevearc/dressing.nvim',
    opts = {
        input = {
            border = 'rounded',
            prefer_width = 0.7,
            title_pos = 'center',
            min_width = { 40, 0.4 },
        },
        select = {
            backend = { 'builtin', 'telescope'  },
            builtin = {
                show_numbers = true,
            },
            telescope = {
                layout_strategy = 'vertical',
                layout_config = {
                    preview_cutoff = false,
                    width = function(_, max_columns, _) return math.min(max_columns, 80) end,
                    height = function(_, _, max_lines) return math.min(max_lines, 15) end,
                },
            },
        },
    },
}
