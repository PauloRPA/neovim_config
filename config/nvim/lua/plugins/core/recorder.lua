return {
    'chrisgrieser/nvim-recorder',
    dependencies = { 'rcarriga/nvim-notify' },
    opts = {
        slots = { 'a', 'p', 'x' },
        lessNotifications = true,
        mapping = {
            startStopRecording = 'q',
            playMacro = 'Q',
            switchSlot = '<C-q>',
            editMacro = 'cq',
            deleteAllMacros = 'dq',
            yankMacro = 'yq',
            -- ⚠️ this should be a string you don't use in insert mode during a macro
            addBreakPoint = '^^',
        },
        performanceOpts = {
            countThreshold = 100,
            lazyredraw = true, -- enable lazyredraw (see `:h lazyredraw`)
            noSystemClipboard = true, -- remove `+`/`*` from clipboard option
            autocmdEventsIgnore = { -- temporarily ignore these autocmd events
                'TextChangedI',
                'TextChanged',
                'InsertLeave',
                'InsertEnter',
                'InsertCharPre',
            },
        },
    },
}
