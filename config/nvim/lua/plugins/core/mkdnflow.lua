return {
    'jakewvincent/mkdnflow.nvim',
    commit = '4f13b87b799dadddba9a56fb48238c7763f88465',
    config = function()
        local mdkwnflow_custom = vim.api.nvim_create_augroup('mdkwnflow_custom', { clear = true })
        vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
            pattern = { '*.md' },
            callback = function()
                vim.o.conceallevel = 2
            end,
            desc = 'Markdown options',
            once = true,
            group = mdkwnflow_custom,
        })

        local mkdnflow = require('mkdnflow')

        mkdnflow.setup({
            modules = {
                bib = true,
                buffers = true,
                conceal = true,
                cursor = true,
                folds = true,
                links = true,
                lists = true,
                maps = true,
                paths = true,
                tables = true,
                yaml = false,
                cmp = false
            },
            new_file_template = {
                use_template = true,
                placeholders = {
                    before = {
                        title = 'link_title',
                        date = 'os_date'
                    },
                    after = {}
                },
                template = '# {{ title }}'
            },
            tables = {
                trim_whitespace = true,
                format_on_move = true,
                auto_extend_rows = false,
                auto_extend_cols = false,
                style = {
                    cell_padding = 1,
                    separator_padding = 1,
                    outer_pipes = true,
                    mimic_alignment = true
                }
            },
            links = {
                style = 'markdown',
                name_is_source = true,
                conceal = false,
                context = 0,
                implicit_extension = nil,
                transform_implicit = true,
                transform_explicit = function(text)
                    text = text:gsub(' ', '-')
                    text = text:lower()
                    local parent = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p:h:t')
                    if parent == 'journal' then
                        text = os.date('%m-%Y/%d')
                    end
                    return (text)
                end
            },
            mappings = {
                MkdnTab = false,
                MkdnSTab = false,
                MkdnNextLink = false,
                MkdnPrevLink = false,
                MkdnCreateLink = false, -- see MkdnEnter
                MkdnFollowLink = false, -- see MkdnEnter
                MkdnTagSpan = false,
                MkdnYankAnchorLink = false,
                MkdnYankFileAnchorLink = false,
                MkdnExtendList = false,

                MkdnGoBack = { 'n', '<C-o>' },
                MkdnGoForward = { 'n', '<C-i>' },
                MkdnEnter = { { 'n', 'v' }, '<CR>' },

                MkdnNextHeading = { 'n', '<C-j>' },
                MkdnPrevHeading = { 'n', '<C-k>' },
                MkdnIncreaseHeading = { 'n', '+' },
                MkdnDecreaseHeading = { 'n', '-' },

                MkdnMoveSource = { 'n', '<F2>' },
                MkdnCreateLinkFromClipboard = { { 'n', 'v' }, '<leader>l' }, -- see MkdnEnter
                MkdnDestroyLink = { 'n', '<A-CR>' },

                MkdnToggleToDo = { { 'n', 'v', 'i' }, '<C-l>' },
                MkdnNewListItem = { { 'n', 'i' }, '<C-n>' },
                MkdnNewListItemBelowInsert = { 'n', 'o' },
                MkdnNewListItemAboveInsert = { 'n', 'O' },
                MkdnUpdateNumbering = { 'n', '<leader>aan' },

                MkdnTableNextCell = { 'i', '<Tab>' },
                MkdnTablePrevCell = { 'i', '<S-Tab>' },
                MkdnTableNextRow = { 'i', '<C-j>' },
                MkdnTablePrevRow = { 'i', '<C-k>' },
                MkdnTableNewRowBelow = { 'n', '<leader>ir' },
                MkdnTableNewRowAbove = { 'n', '<leader>iR' },
                MkdnTableNewColAfter = { 'n', '<leader>ic' },
                MkdnTableNewColBefore = { 'n', '<leader>iC' },

                MkdnFoldSection = false,
                MkdnUnfoldSection = false,
            },
        })
    end
}
