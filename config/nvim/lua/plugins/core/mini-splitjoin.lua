return {
    'echasnovski/mini.splitjoin',
    version = false,
    opts = {
        mappings = {
            toggle = 'gs',
            split = '',
            join = '',
        },
        detect = {
            brackets = { '%b()', '%b[]', '%b{}' },
            separator = ',',
            exclude_regions = { '%b()', '%b[]', '%b{}', '%b""', '%b\'\'' },
        },
    },
}
