local M = {}

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

M.define_dap_signs = function()
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '󰅙', texthl = 'NonText', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'WarningMsg', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '󰺮', texthl = 'DiagnosticHint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'Title', linehl = 'debug_line', numhl = '' })
    vim.cmd([[hi debug_line guibg=#16161e blend=0 cterm=bold gui=bold]])
end

M.setup_lsp_handlers = function()
    for method, config in pairs(HANDLERS_CONFIG) do
        local vim_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = vim.lsp.with(vim_handler, config)
    end
end

return M
