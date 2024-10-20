return {
    'ggandor/leap.nvim',
    init = function()
        vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    end,
    config = function()
        -- Setup leap linewise motions ------------------------------

        local function get_line_starts(winid, skipRange)
            local wininfo = vim.fn.getwininfo(winid)[1]
            local cur_line = vim.fn.line('.')
            -- Skip lines close to the cursor.
            local skip_range = skipRange or 2

            -- Get targets.
            local targets = {}
            local lnum = wininfo.topline
            while lnum <= wininfo.botline do
                local fold_end = vim.fn.foldclosedend(lnum)
                -- Skip folded ranges.
                if fold_end ~= -1 then
                    lnum = fold_end + 1
                else
                    if (lnum < cur_line - skip_range) or (lnum > cur_line + skip_range) then
                        table.insert(targets, { pos = { lnum, 1 } })
                    end
                    lnum = lnum + 1
                end
            end

            -- Sort them by vertical screen distance from cursor.
            local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)['row']
            local function screen_rows_from_cur(t)
                local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])['row']
                return math.abs(cur_screen_row - t_screen_row)
            end
            table.sort(targets, function(t1, t2)
                return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
            end)

            if #targets >= 1 then
                return targets
            end
        end

        -- You can pass an argument to specify a range to be skipped
        -- before/after the cursor (default is +/-2).
        local function leap_line_start(skip_range)
            local winid = vim.api.nvim_get_current_win()
            require('leap').leap({
                target_windows = { winid },
                targets = get_line_starts(winid, skip_range),
            })
        end

        -- END Setup leap linewise motions --------------------------

        local nmap = require('core.keymaps').nmap
        local xmap = require('core.keymaps').xmap

        nmap('<A-s>', '<Plug>(leap-forward)', 'Leap forward')
        nmap('<A-a>', '<Plug>(leap-backward)', 'Leap backward')
        nmap('<A-d>', function()
            leap_line_start()
        end, 'Leap to line')

        -- For maximum comfort, force linewise selection in the mappings:
        xmap('<A-v>', function()
            -- Only force V if not already in it (otherwise it would exit Visual mode).
            if vim.fn.mode(1) ~= 'V' then
                vim.cmd('normal! V')
            end
            leap_line_start()
        end, 'Leap selection linewise')

        vim.keymap.set('o', '|', 'V<cmd>lua leap_line_start()<cr>')

        require('leap.user').set_repeat_keys('<cr>', '<bs>', {
            relative_directions = true,
            modes = { 'n', 'x', 'o' },
        })
    end,
}
