return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    keys = '<leader>e',
    config = function()
        local nmap = require('core.keymaps').nmap

        local ntConfig = require('nvim-tree')
        local ntApi = require('nvim-tree.api')
        local events = require('core.events')

        -- Integration
        events.session_loaded(function()
            ntApi.tree.open()
            vim.api.nvim_input('<C-l>z.')
        end)
        events.git_update(ntApi.tree.reload)
        events.tree_persistence(function()
            if ntApi.tree.is_visible() then
                ntApi.tree.toggle({ focus = false })
                ntApi.tree.toggle({ focus = false })
            end
        end)

        -- Keymappings
        nmap('<leader>e', ntApi.tree.toggle, 'Toggle nvim-tree')
        nmap('<leader>acb', function()
            local currentPath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p:h')

            if ntApi.tree.is_visible() then
                ntApi.tree.toggle()
            end

            ntApi.tree.open({ path = currentPath })
        end, 'Cd tree into current buffer location')

        nmap('<leader>acw', function()
            local currentPath = vim.fn.getcwd()

            if ntApi.tree.is_visible() then
                ntApi.tree.toggle()
            end

            ntApi.tree.open({ path = currentPath })
        end, 'Cd tree into current working dir')

        local function on_attach(bufnr)
            local function opts(desc)
                return { desc = 'NTree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- Default mappings
            ntApi.config.mappings.default_on_attach(bufnr)

            -- Custom mappings
            nmap('<C-w>', function()
                local node = ntApi.tree.get_node_under_cursor()
                if node then
                    vim.cmd.bd({ args = { node.name }, mods = { emsg_silent = true } })
                end
            end, nil, opts('Close buffer'))
        end

        ntConfig.setup({
            on_attach = on_attach,
            disable_netrw = true,
            hijack_netrw = true,
            hijack_cursor = true,
            sync_root_with_cwd = true,
            auto_reload_on_write = true,
            select_prompts = true,
            update_focused_file = { enable = true },
            diagnostics = {
                enable = true,
                debounce_delay = 150,
                icons = {
                    hint = ' ',
                    info = ' ',
                    warning = ' ',
                    error = ' ',
                },
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
                dotfiles = true,
                git_ignored = true,
            },
            view = {
                preserve_window_proportions = true,
                width = {
                    min = 2,
                    max = 30,
                    padding = 1,
                },
            },
        })
    end,
}
