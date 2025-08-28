return {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod', lazy = true },
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()
        vim.g.db_ui_disable_mappings_dbui = 1
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.dbs = {
        }
        local nmap = require('core.keymaps').nevmap(nil, function()
            vim.fn.timer_start(20, function()
                vim.o.cmdheight = 0
            end)
        end)
        nmap('<leader>od', '<cmd>DBUIToggle<CR>', 'Open DadbodUI')
        vim.cmd([[
            autocmd FileType dbui nmap <buffer> o <Plug>(DBUI_SelectLine)
            autocmd FileType dbui nmap <buffer> <CR> <Plug>(DBUI_SelectLine)
            autocmd FileType dbui nmap <buffer> d <Plug>(DBUI_DeleteLine)
            autocmd FileType dbui nmap <buffer> R <Plug>(DBUI_Redraw)
            autocmd FileType dbui nmap <buffer> A <Plug>(DBUI_AddConnection)
            autocmd FileType dbui nmap <buffer> H <Plug>(DBUI_ToggleDetails)
            autocmd FileType dbui nmap <buffer> <leader>W <Plug>(DBUI_SaveQuery)
            autocmd FileType dbui nmap <buffer> <leader>E <Plug>(DBUI_EditBindParameters)
            autocmd FileType dbout nmap <buffer> <C-c> <C-w>c
            autocmd FileType dbout nmap <buffer> q <C-w>c
            autocmd FileType sql nmap <buffer> <F5> <Plug>(DBUI_ExecuteQuery)
            autocmd FileType sql xmap <buffer> <F5> <Plug>(DBUI_ExecuteQuery)
        ]])
    end,
}
