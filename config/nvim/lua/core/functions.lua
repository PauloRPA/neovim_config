local M = {}

local LINE_SEPARATOR = '[^\r\n]+'

local git_lsfile_commands = {
    deleted = 'git ls-files -d',
    modified = 'git ls-files -m',
    untracked = 'git ls-files -o --exclude-standard',
}

M.get_current_git_files = function()
    local git_files = {}

    for operation, command in pairs(git_lsfile_commands) do
        git_files[operation] = {}
        for file in string.gmatch(vim.fn.system(command), LINE_SEPARATOR) do
            table.insert(git_files[operation], file)
        end
    end

    return git_files
end

M.open_current_git_files = function()
    local git_files = M.get_current_git_files()

    for operation, _ in pairs(git_lsfile_commands) do
        for _, file in ipairs(git_files[operation]) do
            vim.cmd.e(file)
        end
    end
end

return M
