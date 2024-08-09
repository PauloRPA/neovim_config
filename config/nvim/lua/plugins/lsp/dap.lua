return {
    'mfussenegger/nvim-dap',
    -- tag = '0.8.0',
    config = function()
        local dap = require('dap')

        vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '󰅙', texthl = 'NonText', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'WarningMsg', linehl = '', numhl = '' })
        vim.fn.sign_define('DapLogPoint', { text = '󰺮', texthl = 'DiagnosticHint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped', { text = '', texthl = 'Title', linehl = 'debug_line', numhl = '' })

        dap.defaults.fallback.terminal_win_cmd = 'set splitbelow | 7split new | set nosplitbelow'
    end,
}
