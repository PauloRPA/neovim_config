return {
    'hrsh7th/nvim-cmp',
    commit = '93f385c17611039f3cc35e1399f1c0a8cf82f1fb',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'L3MON4D3/LuaSnip',
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        cmp.setup({
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
                    if entry.source.name == 'html-css' then
                        vim_item.menu = entry.completion_item.menu
                    end
                    return vim_item
                end
            },
            sources = cmp.config.sources({
                {
                    name = 'html-css',
                    option = {
                        enable_on = {
                            'html'
                        },                                           -- set the file types you want the plugin to work on
                        file_extensions = { 'css', 'sass', 'less' }, -- set the local filetypes from which you want to derive classes
                        style_sheets = {
                            -- example of remote styles, only css no js for now
                            'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css',
                            -- 'https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css',
                        }
                    }
                },
                { name = 'nvim_lsp_signature_help' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer', keyword_length = 3 },
                { name = 'path', keyword_length = 3 },
            })
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
