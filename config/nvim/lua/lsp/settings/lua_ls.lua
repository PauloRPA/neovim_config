return {
    autostart = true,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files and plugins
                library = {
                    vim.env.VIMRUNTIME .. '/',
                    vim.fn.stdpath('data') .. '/lazy/',
                },
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        }
    }
}
