return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    keys = "<leader>e",
    config = function()
        local ntConfig = require('nvim-tree')
        local ntApi = require('nvim-tree.api')

        -- Keymappings
        vim.keymap.set('n', '<leader>e', ntApi.tree.toggle, { desc = 'NTree: [<leader>e] Toggle nvim-tree' })

        local function on_attach(bufnr)
            local function opts(desc)
                return { desc = 'NTree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- Default mappings
            ntApi.config.mappings.default_on_attach(bufnr)

            -- Custom mappings
            vim.keymap.set('n', '<C-w>', function()
                local node = ntApi.tree.get_node_under_cursor()
                if node then
                    vim.cmd.bd({ args = { node.name }, mods = { emsg_silent = true, } })
                end
            end, opts('Close buffer'))
        end

        ntConfig.setup({
            on_attach = on_attach,
            disable_netrw = true,
            hijack_netrw = true,
            hijack_cursor = true,
            sync_root_with_cwd = true,
            auto_reload_on_write = true,
            select_prompts = true,
            update_focused_file = { enable = true, },
            diagnostics = {
                enable = true,
                debounce_delay = 150,
                icons = {
                    hint = ' ',
                    info = ' ',
                    warning = ' ',
                    error = ' '
                }
            },
            renderer = {
                group_empty = true,
                highlight_git = true,
                highlight_diagnostics = true,
                highlight_opened_files = 'name',
                indent_markers = {
                    enable = true,
                    inline_arrows = true,
                },
                special_files = {
                    'Cargo.toml',
                    'Makefile',
                    'README.md',
                    'readme.md',
                    'pom.xml',
                },
            },
            filters = {
                dotfiles = false,
                git_ignored = true,
            },
            view = {
                width = {
                    min = 2,
                    max = 30,
                    padding = 1,
                }
            }
        })
    end
}
