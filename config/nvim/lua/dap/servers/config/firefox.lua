return function(config)
    config.configurations = {
        {
            firefoxExecutable = '/usr/bin/firefox',
            name = 'Firefox: Debug',
            reAttach = true,
            request = 'launch',
            type = 'firefox',
            url = 'http://localhost:3000',
            webRoot = '${workspaceFolder}',
            file = vim.fs.find({ 'index.html' }, { path = vim.fn.getcwd() })[1],
        },
    }

    require('mason-nvim-dap').default_setup(config)
    require('dap.keymaps').attachDapKeymapsToBuf()
end
