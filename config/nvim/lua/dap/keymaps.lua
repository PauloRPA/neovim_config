M = {}

local dap = require('dap')
local nmap = require('core.keymaps').nmap

local LAST_ARGS = ''

M.args = function()
    if LAST_ARGS == nil or LAST_ARGS == '' then
        return nil
    end
    return { LAST_ARGS }
end

M.update_args = function()
    vim.ui.input({ prompt = 'Application args:', default = LAST_ARGS }, function(input)
        if input then
            LAST_ARGS = input
        end
    end)
    return LAST_ARGS
end

M.attachDapKeymapsToBuf = function()
    -- Debugging
    nmap('<C-b>', dap.toggle_breakpoint, 'Toggle [B]reakpoint')
    nmap('<A-n>', dap.restart_frame, 'Restart frame')
    nmap('<A-f>', dap.focus_frame, 'Focus frame')
    nmap('<A-o>', dap.step_over, 'Step [O]ver')
    nmap('<A-O>', dap.step_out, 'Step [O]ut')
    nmap('<A-i>', function()
        dap.step_into({ askForTargets = true })
    end, 'Step into')

    nmap('<leader>n', function()
        local widgets = require('dap.ui.widgets')
        widgets.cursor_float(widgets.frames).open()
    end, 'Show Frames at cursor')

    -- Breakpoints
    nmap('<leader>bl', dap.list_breakpoints, 'List breakpoints')
    nmap('<leader>bc', dap.clear_breakpoints, 'Clear breakpoints')

    nmap('<leader>bh', function()
        vim.ui.input({ prompt = 'Number of hits' }, function(hits)
            if hits then
                dap.set_breakpoint(nil, hits, nil)
            else
                vim.notify('Operation aborted.')
            end
        end)
    end, 'Set hit breakpoint')

    nmap('<leader>bp', function()
        dap.toggle_breakpoint(nil, nil, vim.api.nvim_get_current_line())
    end, 'Set print breakpoint')

    -- Run
    nmap('<A-r>', function()
        vim.cmd.wa()
        dap.run_last()
    end, 'Run last')

    nmap('<A-x>', function()
        dap.terminate()
    end, 'Terminate')

    nmap('<A-c>', function()
        vim.cmd.wa()
        dap.continue()
    end, 'Dap continue')

    nmap('<A-q>', function()
        M.args = { M.update_args() }
    end, 'Set Application args')
end

return M
