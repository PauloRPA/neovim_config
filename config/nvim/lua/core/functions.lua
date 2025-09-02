local M = {}

local LINE_SEPARATOR = '[^\r\n]+'

local git_lsfile_commands = {
    -- deleted = 'git ls-files -d',
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

M.wrap_text = function(text, prefix, suffix, motion)
    motion = motion or 'ciw'
    prefix = prefix or ''
    suffix = suffix or ''

    local keys =
        vim.api.nvim_replace_termcodes(prefix .. '"t' .. motion .. text .. '<Esc><Esc>"tP' .. suffix, true, false, true)
    vim.api.nvim_feedkeys(keys, 'L', false)
end

M.input = function(input)
    input = input and vim.api.nvim_replace_termcodes(input, true, false, true) or ''
    vim.api.nvim_feedkeys(input, 'm', false)
end

M.insert_at_start = function(ch, isInsertMode, after)
    after = after and vim.api.nvim_replace_termcodes(after, true, false, true) or ''
    local prefix = isInsertMode and '<Esc>' or ''
    local cmd = vim.api.nvim_replace_termcodes(prefix .. 'I' .. ch .. '<esc>', true, false, true)
    if string.match(vim.api.nvim_get_current_line(), ch) ~= ch then
        vim.api.nvim_feedkeys(cmd .. after, 't', true)
    end
end

M.insert_at_end = function(ch, after)
    after = after and vim.api.nvim_replace_termcodes(after, true, false, true) or ''
    local cmd = ''
    if string.match(vim.api.nvim_get_current_line(), ch) == ch then
        cmd = vim.api.nvim_replace_termcodes('<Esc><Esc>A', true, false, true)
    else
        cmd = vim.api.nvim_replace_termcodes('<Esc><Esc>A' .. ch, true, false, true)
    end
    vim.api.nvim_feedkeys(cmd .. after, 'm', false)
end

M.find_mason_package = function(packageName, pathToAppend)
    pathToAppend = pathToAppend or ''
    return vim.fn.expand('$MASON/packages/' .. packageName .. pathToAppend)
end

M.touch_env_if_not_exists = function(project_dir)
    vim.fn.mkdir(project_dir, 'p')
    if vim.fn.filewritable(project_dir .. '/.env') == 0 then
        local file = io.open(project_dir .. '/.env', 'a')
        if file then
            file:close()
        end
    end
end

return M
