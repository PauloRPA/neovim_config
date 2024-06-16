local M = {}

local options = {
    mouse = 'a', -- Enable mouse mode
    clipboard = 'unnamedplus', -- Sync clipboard between OS and Neovim.
    completeopt = 'menu,menuone,noselect', -- Set completeopt to have a better completion experience
    hlsearch = false, -- Set highlight on search
    breakindent = true, -- Enable break indent
    confirm = true,
    shiftwidth = 0,
    tabstop = 4,
    smartindent = true,
    autoindent = true,
    expandtab = true,
    undofile = true, -- Save undo history
    ignorecase = true, -- Case insensitive searching UNLESS /C or capital in search
    smartcase = true,
    updatetime = 400, -- Decrease update time
    termguicolors = true, -- Set colorscheme
    number = true, -- Make line numbers default
    relativenumber = true, -- Make line numbers default
    scrolloff = 6,
    autoread = true,
}

M.load = function()
    for option, value in pairs(options) do
        vim.o[option] = value
    end

    vim.wo.signcolumn = 'auto'

    vim.g.mapleader = ' ' -- Set <space> as the leader key
    vim.g.maplocalleader = ' ' -- Set <space> as the leader key

    vim.g.loaded_netrw = 1 -- Disables netrw
    vim.g.loaded_netrwPlugin = 1 -- Disables netrw

    if vim.g.neovide then
        local nmap = require('core.keymaps').nmap
        vim.api.nvim_set_var('neovide_scale_factor', 0.9)
        nmap('<C-+>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>')
        nmap('<C-->', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>')
        nmap('<C-0>', ':lua vim.g.neovide_scale_factor = 0.9<CR>')
    end

    vim.cmd.colorscheme('torte')
end

return M
