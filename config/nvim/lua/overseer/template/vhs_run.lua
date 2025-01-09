return {
    name = 'run',
    builder = function(_)
        local file_path = vim.fn.expand('%')
        local file_dir = vim.fn.fnamemodify(file_path, ':p:h')
        local file_name_noext = vim.fn.fnamemodify(file_path, ':p:t:r')

        return {
            cmd = { 'mpv' },
            args = { file_name_noext .. '.gif' },
            name = 'run',
            cwd = file_dir,
            components = { 'default' },
        }
    end,
    desc = 'Run the gif from this tape',
    priority = 50,
    condition = {
        filetype = { 'vhs' },
    },
}
