return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'rcarriga/cmp-dap',
        'L3MON4D3/LuaSnip',
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

        local function detail_sort(entry1, entry2)
            if not entry1.completion_item.detail then
                return nil
            end

            if not entry2.completion_item.detail then
                return nil
            end

            local diff_detail = #entry1.completion_item.detail - #entry2.completion_item.detail
            if diff_detail < 0 then
                return true
            elseif diff_detail > 0 then
                return false
            end

            return nil
        end

        local function clientName(client)
            if client.source.source.client then
                return client.source.source.client.name
            end
        end

        local function emmetls_htmlls_length_sorting(entry1, entry2)
            local emmet_ls = 'emmet_language_server'
            local client_name1 = clientName(entry1)
            local client_name2 = clientName(entry2)
            if client_name1 and client_name2 then
                if client_name2 == emmet_ls then
                    return client_name1 ~= client_name2
                end
                if client_name1 == emmet_ls then
                    return false
                end
            end
            return cmp.config.compare.length(entry1, entry2)
        end

        local lsp_server_icons = {
            emmet_ls = '󰈑 ',
            html = '󰬏 ',
        }

        cmp.setup({
            enabled = function()
                return vim.api.nvim_get_option_value('buftype', { buf = 0 }) ~= 'prompt'
                    or require('cmp_dap').is_dap_buffer()
            end,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- ['<C-d>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior, count = 4 }),
                -- ['<C-u>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior, count = 4 }),
                ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior, count = 1 }),
                ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior, count = 1 }),
                ['<C-n>'] = cmp.mapping.scroll_docs(4),
                ['<C-p>'] = cmp.mapping.scroll_docs(-4),
                ['<Tab>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
            }),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                format = function(entry, vim_item)
                    if entry.source.name == 'nvim_lsp' then
                        local server_name = entry.source.source.client.config.name
                        if lsp_server_icons[server_name] then
                            vim_item.menu = lsp_server_icons[server_name]
                        end
                    end
                    return vim_item
                end,
            },
            sorting = {
                comparators = {
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.group_index,
                    cmp.config.compare.locality,
                    cmp.config.compare.length,
                    cmp.config.compare.recently_used,
                },
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp_signature_help', group_index = 1 },
                { name = 'nvim_lsp', group_index = 1 },
                { name = 'luasnip', group_index = 1 },
                { name = 'path', group_index = 2 },
                { name = 'buffer', group_index = 2 },
            }),
            experimental = {
                ghost_text = true,
            },
        })

        cmp.setup.filetype('html', {
            sorting = {
                comparators = {
                    emmetls_htmlls_length_sorting,
                    cmp.config.compare.score,
                    cmp.config.compare.order,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.exact,
                },
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp_signature_help', id = 1 },
                { name = 'nvim_lsp', id = 1 },
                { name = 'luasnip', id = 1 },
                { name = 'path', id = 2 },
                { name = 'buffer', id = 2 },
            }),
        })

        cmp.setup.filetype('javascript', {
            sorting = {
                comparators = {
                    cmp.config.compare.score,
                    cmp.config.compare.length,
                    cmp.config.compare.group_index,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.exact,
                },
            },
            sources = cmp.config.sources({
                { name = 'luasnip', group_index = 1 },
                { name = 'nvim_lsp_signature_help', group_index = 1 },
                { name = 'nvim_lsp', group_index = 1 },
                { name = 'path', group_index = 2 },
                { name = 'buffer', group_index = 2 },
            }),
        })

        cmp.setup.filetype('sql', {
            sorting = {
                comparators = {
                    cmp.config.compare.score,
                    cmp.config.compare.scopes,
                    cmp.config.compare.length,
                    cmp.config.compare.group_index,
                },
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp_signature_help', group_index = 1 },
                { name = 'nvim_lsp', group_index = 1 },
                { name = 'vim-dadbod-completion', group_index = 1 },
                { name = 'luasnip', group_index = 1 },
                { name = 'path', group_index = 2 },
                { name = 'buffer', group_index = 2 },
            }),
        })

        cmp.setup.filetype('java', {
            sorting = {
                comparators = {
                    cmp.config.compare.score,
                    cmp.config.compare.scopes,
                    detail_sort,
                    cmp.config.compare.group_index,
                },
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp_signature_help', group_index = 1 },
                { name = 'nvim_lsp', group_index = 1 },
                { name = 'luasnip', group_index = 1 },
                { name = 'path', group_index = 2 },
                { name = 'buffer', group_index = 2 },
            }),
        })

        cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
            sources = {
                { name = 'dap' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
            },
        })

        local cmdline_maps = {
            ['<C-p>'] = {
                c = function(fallback)
                    fallback()
                end,
            },
            ['<C-n>'] = {
                c = function(fallback)
                    fallback()
                end,
            },
            -- ['<C-d>'] = { c = function(fallback) if cmp.visible() then cmp.select_next_item({ behavior = cmp.SelectBehavior, count = 4 }) else fallback() end end},
            -- ['<C-u>'] = { c = function(fallback) if cmp.visible() then cmp.select_prev_item({ behavior = cmp.SelectBehavior, count = 4 }) else fallback() end end},
            ['<C-j>'] = {
                c = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior, count = 1 })
                    else
                        fallback()
                    end
                end,
            },
            ['<C-k>'] = {
                c = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior, count = 1 })
                    else
                        fallback()
                    end
                end,
            },
            ['<Tab>'] = {
                c = function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                    else
                        fallback()
                    end
                end,
            },
        }

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(cmdline_maps),
            sources = {
                { name = 'buffer' },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(cmdline_maps),
            sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
        })
    end,
}
