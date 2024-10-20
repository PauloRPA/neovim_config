local M = {}

local pallete = {
    bg = '#282727',
    deep_bg = '#0d0c0c',
    breakpoint = '#e82424',
    warning = '#ff9e3b',
    active = '#8ba4b0',
    print = '#6a9589',
    inactive = '#625e5a',
}

local HANDLERS_CONFIG = {
    ['textDocument/hover'] = {
        border = 'single',
        title = 'Hover',
    },
}

M.load = function()
    M.define_dap_signs()
    M.setup_lsp_handlers()
end

M.set_highlights = function()
    vim.api.nvim_set_hl(0, 'breakpoint', { fg = pallete.breakpoint, bg = pallete.bg })
    vim.api.nvim_set_hl(0, 'breakpoint_rejected', { fg = pallete.inactive, bg = pallete.bg })
    vim.api.nvim_set_hl(0, 'breakpoint_condition', { fg = pallete.warning, bg = pallete.bg })
    vim.api.nvim_set_hl(0, 'breakpoint_print', { fg = pallete.print, bg = pallete.bg })
    vim.api.nvim_set_hl(0, 'breakpoint_active', { fg = pallete.active, bg = pallete.bg })
    vim.api.nvim_set_hl(0, 'debug_line', { bg = pallete.deep_bg, blend = 0, bold = true })
end

M.define_dap_signs = function()
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'breakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '󰅙', texthl = 'breakpoint_rejected', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'breakpoint_condition', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '󰺮', texthl = 'breakpoint_print', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'breakpoint_active', linehl = 'debug_line', numhl = '' })
end

M.setup_lsp_handlers = function()
    for method, config in pairs(HANDLERS_CONFIG) do
        local vim_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = vim.lsp.with(vim_handler, config)
    end
end

return M
