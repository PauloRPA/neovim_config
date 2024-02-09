return {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6', --recomended as each new version will have breaking changes
    enabled = true,
    opts = {
        { '*', '*', dosuround = true, suround = true, multiline = true, ft = { 'markdown' } },
        bs = {                                   -- *ultimate-autopair-map-backspace-config*
            map = { '<bs>', '<C-h>', '<C-w>' },  --string or table
            cmap = { '<bs>', '<C-h>', '<C-w>' }, --string or table
            space = 'balance',                   --false, true or 'balance'
            indent_ignore = true,
        },
        cr = { -- *ultimate-autopair-map-newline-config*
            autoclose = true,
        },
        space = { -- *ultimate-autopair-map-space-config*
            check_box_ft = { 'markdown', 'md', 'vimwiki' },
        },
        fastwarp = { -- *ultimate-autopair-map-fastwarp-config*
            hopout = true,
        },
        close = {           -- *ultimate-autopair-map-close-config*
            enable = (true),
            map = '<A-k>',  --string or table
            cmap = '<A-k>', --string or table
        },
        tabout = {          -- *ultimate-autopair-map-tabout-config*
            enable = true,
            map = '<A-l>',  --string or table
            cmap = '<A-l>', --string or table
            hopout = true,
        },
        config_internal_pairs = { -- *ultimate-autopair-pairs-configure-default-pairs*
            { '"""', '"""', suround = true, newline = true, ft = { 'python', 'java' } },
            { '"', '"', suround = true, multiline = true, alpha = { 'txt' } },
        },
    },
}
