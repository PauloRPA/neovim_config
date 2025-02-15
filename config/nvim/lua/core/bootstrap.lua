local M = {}

local nmap = require('core.keymaps').nmap
nmap('<leader>o;', '<cmd>Lazy<CR>', 'Open Lazy')

local function bootstrap()
    local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable', -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)
end

local function setup()
    local lazy = require('lazy')

    lazy.setup({
        spec = {
            { import = 'plugins.core' },
            { import = 'plugins.lsp' },
        },
    }, {
        install = {
            colorscheme = { 'tokyonight-night' },
        },
        checker = {
            enabled = true,
            notify = false,
        },
        change_detection = {
            notify = true,
        },
    })
end

M.load = function()
    bootstrap()
    setup()
end

return M
