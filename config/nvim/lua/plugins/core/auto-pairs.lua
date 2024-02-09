return {
    'windwp/nvim-autopairs',
    enabled = false,
    opts = {
        map_c_h = true,
        map_c_w = true,
        fast_wrap = {
            map = '<M-e>',
            chars = { '{', '[', '(', '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
            offset = 0, -- Offset from pattern match
            end_key = ".",
            keys = 'qwertyuiopzxcvbnmasdfghjkl',
            check_comma = true,
            highlight = 'PmenuSel',
            highlight_grey = 'LineNr',
        },
    },
}
