return {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    config = function()
        local multicursor = require('multicursor-nvim')
        multicursor.setup()

        local nxmap = require('core.keymaps').multi('nx')
        local nmap = require('core.keymaps').nmap
        local xmap = require('core.keymaps').xmap
        local opts = {}

        -- Add or skip cursor above/below the main cursor.
        nxmap('<up>', function() multicursor.lineAddCursor(-1) end, 'Multicursor: lineAddCursor', opts)
        nxmap('<down>', function() multicursor.lineAddCursor(1) end, 'Multicursor: lineAddCursor', opts)
        nxmap('<leader><up>', function() multicursor.lineSkipCursor(-1) end, 'Multicursor: lineSkipCursor', opts)
        nxmap('<leader><down>', function() multicursor.lineSkipCursor(1) end, 'Multicursor: lineSkipCursor', opts)
        nxmap('g[', multicursor.addCursorOperator, 'Multicursor: addCursorOperator', opts)
        nxmap('<leader><c-f>', multicursor.duplicateCursors, 'Multicursor: duplicateCursors', opts)
        nxmap('<leader><c-a>', multicursor.searchAllAddCursors, 'Multicursor: searchAllAddCursors', opts)
        nxmap('<leader>A', multicursor.matchAllAddCursors, 'Multicursor: matchAllAddCursors', opts)
        xmap('<leader>t', function() multicursor.transposeCursors(1) end, 'Multicursor: transposeCursors', opts)
        xmap('<leader>T', function() multicursor.transposeCursors(-1) end, 'Multicursor: transposeCursors', opts)
        xmap('M', multicursor.matchCursors, 'Multicursor: matchCursors', opts)

        -- Add or skip adding a new cursor by matching word/selection
        nxmap('<A-8>', function() multicursor.matchAddCursor(1) end, 'Multicursor: matchAddCursor', opts)
        nxmap('<A-*>', function() multicursor.matchSkipCursor(1) end, 'Multicursor: matchSkipCursor', opts)
        nxmap('<leader>N', function() multicursor.matchAddCursor(-1) end, 'Multicursor: matchAddCursor', opts)
        nxmap('<leader>S', function() multicursor.matchSkipCursor(-1) end, 'Multicursor: matchSkipCursor', opts)

        -- Add and remove cursors with control + left click.
        nmap('<c-leftmouse>', multicursor.handleMouse, 'Multicursor mouse: handleMouse', opts)
        nmap('<c-leftdrag>', multicursor.handleMouseDrag, 'Multicursor mouse: handleMouseDrag', opts)
        nmap('<c-leftrelease>', multicursor.handleMouseRelease, 'Multicursor mouse: handleMouseRelease', opts)

        -- Disable and enable cursors.
        nxmap('<c-f>', multicursor.toggleCursor, 'Multicursor: toggleCursor', opts)

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        multicursor.addKeymapLayer(function(layerSet)
            -- Select a different cursor as the main one.
            layerSet({ 'n', 'x' }, '<left>', multicursor.prevCursor)
            layerSet({ 'n', 'x' }, '<right>', multicursor.nextCursor)

            -- Delete the main cursor.
            layerSet({ 'n', 'x' }, '<leader>x', multicursor.deleteCursor)

            -- Clear cursors using leader 0.
            layerSet('n', '<leader>0', function() multicursor.clearCursors() end)

            layerSet({ 'n', 'x' }, 'g<c-a>', multicursor.sequenceIncrement)
            layerSet({ 'n', 'x' }, 'g<c-x>', multicursor.sequenceDecrement)

            -- Enable and clear cursors using escape.
            layerSet('n', '<esc>', function()
                if not multicursor.cursorsEnabled() then
                    multicursor.enableCursors()
                else
                    multicursor.clearCursors()
                end
            end)
        end)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, 'MultiCursorCursor', { reverse = true })
        hl(0, 'MultiCursorVisual', { link = 'Visual' })
        hl(0, 'MultiCursorSign', { link = 'SignColumn' })
        hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
        hl(0, 'MultiCursorDisabledCursor', { reverse = true })
        hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
        hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
    end
}
