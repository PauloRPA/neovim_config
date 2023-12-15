return {
    'tpope/vim-speeddating',
    dependencies = {
        'tpope/vim-repeat',
    },
    config = function() 
        vim.cmd({ cmd = 'SpeedDatingFormat', args = { '%d/%m/%Y' }})
        vim.cmd({ cmd = 'SpeedDatingFormat', args = { '%-I:%M:%S' }})
    end
}
