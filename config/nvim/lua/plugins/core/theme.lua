return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        local function telescopeHL(hl, c)
            local prompt = '#24283b'
            local title_text = '#7dcfff'
            local result_text = '#c2daff'

            hl.TelescopeNormal = {
                bg = c.bg_dark,
                fg = result_text,
            }
            hl.TelescopeBorder = {
                bg = c.bg_dark,
                fg = c.bg_dark,
            }
            hl.TelescopePromptNormal = {
                bg = prompt,
            }
            hl.TelescopePromptBorder = {
                bg = prompt,
                fg = prompt,
            }
            hl.TelescopePromptTitle = {
                bg = prompt,
                fg = title_text,
            }
            hl.TelescopePreviewTitle = {
                bg = c.bg_dark,
                fg = title_text,
            }
            hl.TelescopeResultsTitle = {
                bg = c.bg_dark,
                fg = title_text,
            }
        end

        local tokyonight = require('tokyonight')
        tokyonight.setup({
            style = 'moon',
            on_highlights = function(hl, c)
                telescopeHL(hl, c)
            end,
        })
        vim.cmd('colorscheme tokyonight')
    end,
}
