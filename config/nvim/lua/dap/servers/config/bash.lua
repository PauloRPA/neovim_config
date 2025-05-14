return function(config)
    local BASHDB_DIR = ''
    if
        require('mason-registry').has_package('bash-debug-adapter')
        and require('mason-registry').get_package('bash-debug-adapter'):is_installed()
    then
        BASHDB_DIR = vim.fn.expand("$MASON/packages/bash-debug-adapter")
            .. '/extension/bashdb_dir'
    end

    config.configurations = {
        {
            type = 'bash',
            request = 'launch',
            name = 'Bash: Launch file',
            program = '${file}',
            cwd = '${fileDirname}',
            pathBashdb = BASHDB_DIR .. '/bashdb',
            pathBashdbLib = BASHDB_DIR,
            pathBash = 'bash',
            pathCat = 'cat',
            pathMkfifo = 'mkfifo',
            pathPkill = 'pkill',
            env = {},
            args = {},
        },
    }

    require('mason-nvim-dap').default_setup(config)
    require('dap.keymaps').attachDapKeymapsToBuf()
end
