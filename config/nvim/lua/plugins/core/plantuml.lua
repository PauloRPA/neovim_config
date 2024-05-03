return {
    'https://github.com/Groveer/plantuml.nvim',
    config = function()
        local puml = vim.api.nvim_create_augroup('Puml mappings', { clear = true })
        vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
            pattern = { '*.plantuml', '*.plant', '*.uml', '*.iuml', '*.puml', '*.pu' },
            callback = function(ev)
                local opts = { buffer = ev.buf, noremap = true, silent = true }
                local nmap = require('core.keymaps').nmap
                nmap('<leader>aar', '<cmd>PlantUMLRun<CR>', 'Run PlantUml and open on Feh', opts)
            end,
            desc = 'puml mappings',
            once = true,
            group = puml,
        })

        require('plantuml').setup({
            renderer = {
                type = 'image',
                options = {
                    prog = 'feh',
                    dark_mode = true,
                    split_cmd = 'vsplit', -- Allowed values: `split`, `vsplit`.
                }
            },
            render_on_write = true, -- Set to false to disable auto-rendering.
        })
    end
}
