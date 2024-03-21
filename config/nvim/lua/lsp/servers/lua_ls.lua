return {
    -- https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/docs/format_config_EN.md
    autostart = true,
    settings = {
        Lua = {
            format = {
                enable = true,
                defaultConfig = {
                    align_continuous_assign_statement = 'false',
                    align_continuous_rect_table_field = 'false',
                    align_array_table = 'false',
                    quote_style = 'single',
                }
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                { vim.env.VIMRUNTIME .. '/' }, -- Make the server aware of Neovim runtime files and plugins
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        }
    }
}
