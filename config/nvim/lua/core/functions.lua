local M = {}

local LINE_SEPARATOR = '[^\r\n]+'

local git_lsfile_commands = {
    deleted = 'git ls-files -d',
    modified = 'git ls-files -m',
    untracked = 'git ls-files -o --exclude-standard',
}

--- Returns a table with files marked as deleted, modified or untracked by git.
---@return table with deleted, modified and untracked files.
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

--- Open files marked as deleted, modified or untracked by git.
M.open_current_git_files = function()
    local git_files = M.get_current_git_files()

    for operation, _ in pairs(git_lsfile_commands) do
        for _, file in ipairs(git_files[operation]) do
            vim.cmd.e(file)
        end
    end
end

--- Returns a string with all LSP client names attached to the current buffer.
---@return string lsp names
M.get_attached_lsp_client_names = function()
    local names = ''
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
        names = names .. client.name .. ' '
    end
    return names
end

--- Returns the current cwd
---@return string current cwd
M.cwd_root = function()
    return vim.fn.getcwd()
end

--- Runs vim rooter then returns the current cwd
---@return string current cwd
M.cwd_root_rooter = function()
    vim.cmd([[Rooter]])
    return vim.fn.getcwd()
end

--- Tries to find a path with the table of filenames given.
---@param reference_files table of filenames (with extension) that will be used to search for a path
--- eg: { 'gradlew', '.git', 'mvnw', 'pom.xml' }
---@return string path found based on the reference filenames provided
M.find_root_fs = function(reference_files)
    return vim.fs.dirname(vim.fs.find(reference_files, { upward = true })[1])
end

--- Checks if a string is blank or null
---@param str string to check
---@return boolean false if the str is not blank
M.is_str_blank = function(str)
    return not str or str == ''
end

--- Checks if a string is blank or null
---@param str string to check
---@return boolean true if the str is not blank
M.is_str_not_blank = function(str)
    return str and str ~= ''
end

return M
