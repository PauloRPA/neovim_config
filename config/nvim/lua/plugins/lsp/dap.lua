return {
    'mfussenegger/nvim-dap',
    tag = '0.7.0',
    config = function()
        local dap = require('dap')

        dap.defaults.fallback.terminal_win_cmd = 'set splitbelow | 7split new | set nosplitbelow'
    end
}
