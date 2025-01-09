return {
    name = 'record',
    builder = function(_)
        local file_path = vim.fn.expand('%')
        local file_name = vim.fn.fnamemodify(file_path, ':p:t')
        local file_dir = vim.fn.fnamemodify(file_path, ':p:h')

        return {
            cmd = { 'vhs' },
            args = { file_name },
            name = 'record',
            cwd = file_dir,
            components = { 'default' },
        }
    end,
    desc = 'Record this tape',
    priority = 50,
    condition = {
        filetype = { 'vhs' },
    },
}
