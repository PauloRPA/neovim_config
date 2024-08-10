return {
    'mfussenegger/nvim-dap',
    config = function()
        local dap = require('dap')
        dap.defaults.fallback.terminal_win_cmd = 'set splitbelow | 7split new | set nosplitbelow'
    end,
}
