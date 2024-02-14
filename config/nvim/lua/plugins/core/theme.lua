return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        local function telescopeHL(hl, c)
            local prompt = '#24283b'
            hl.TelescopeNormal = {
                bg = c.bg_dark,
                fg = c.fg_dark,
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
                fg = prompt,
            }
            hl.TelescopePreviewTitle = {
                bg = c.bg_dark,
                fg = c.bg_dark,
            }
            hl.TelescopeResultsTitle = {
                bg = c.bg_dark,
                fg = c.bg_dark,
            }
        end

        require('tokyonight').setup({
            style = 'night',
            on_highlights = function(hl, c)
                telescopeHL(hl, c)
            end,
        })

        vim.cmd.colorscheme('tokyonight-night')
    end
}
