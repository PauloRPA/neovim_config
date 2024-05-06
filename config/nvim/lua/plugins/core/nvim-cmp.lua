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
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        local function emmet_lsSorting(entry1, entry2)
            if entry2.source.source.client and entry2.source.source.client.name == 'emmet_ls' then
                if entry1.source.source.client then
                    return entry1.source.source.client.name ~= entry2.source.source.client.name
                else
                    return true
                end
            end
            return false
        end

        local lsp_server_icons = {
            emmet_ls = '󰈑 ',
            html = '󰬏 ',
        }

        cmp.setup({
            enabled = function()
                return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require('cmp_dap').is_dap_buffer()
            end,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
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
                end
            },
            sorting = {
                comparators = {
                    cmp.config.compare.score,
                    emmet_lsSorting,
                    cmp.config.compare.exact,
                    cmp.config.compare.recently_used,
                }
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp_signature_help', group_index = 1 },
                { name = 'nvim_lsp', group_index = 1 },
                { name = 'luasnip', group_index = 1 },
                { name = 'path', keyword_length = 2, group_index = 2 },
                { name = 'buffer', keyword_length = 3, group_index = 2 },
            })
        })

        cmp.setup.filetype({ 'html', 'css' }, {
            sorting = {
                comparators = {
                    emmet_lsSorting,
                    cmp.config.compare.score,
                    cmp.config.compare.exact,
                    cmp.config.compare.recently_used,
                }
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp_signature_help', group_index = 1 },
                { name = 'nvim_lsp', group_index = 1 },
                { name = 'luasnip', group_index = 1 },
                { name = 'path', keyword_length = 2, group_index = 2 },
            })
        })

        cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
            sources = {
                { name = 'dap' }, { name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'buffer' },
            },
        })

        local cmdline_maps = {
            ['<C-p>'] = { c = function(fallback) fallback() end },
            ['<C-n>'] = { c = function(fallback) fallback() end },
            -- ['<C-d>'] = { c = function(fallback) if cmp.visible() then cmp.select_next_item({ behavior = cmp.SelectBehavior, count = 4 }) else fallback() end end},
            -- ['<C-u>'] = { c = function(fallback) if cmp.visible() then cmp.select_prev_item({ behavior = cmp.SelectBehavior, count = 4 }) else fallback() end end},
            ['<C-j>'] = {
                c = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior, count = 1 })
                    else
                        fallback()
                    end
                end
            },
            ['<C-k>'] = {
                c = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior, count = 1 })
                    else
                        fallback()
                    end
                end
            },
            ['<Tab>'] = {
                c = function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                    else
                        fallback()
                    end
                end
            },
        }

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(cmdline_maps),
            sources = {
                { name = 'buffer' },
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(cmdline_maps),
            sources = cmp.config.sources(
                { { name = 'path' } },
                { { name = 'cmdline' } })
        })
    end,
}
