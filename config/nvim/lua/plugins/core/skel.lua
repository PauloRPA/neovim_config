return {
    'motosir/skel-nvim',
    config = function()
        local skel = require('skel-nvim')
        local skeld = require('skel-nvim.defaults')

        local function simple_filename()
            return vim.fn.fnamemodify(vim.fn.expand('%'), ':p:t:r')
        end

        local mappings = {
            -- ['*.java'] = 'java.skel',
        }
        local skel_template_path = require('core.info').path_skel_templates
        for _, current_skel in pairs(vim.fn.readdir(skel_template_path)) do
            local filename = vim.fn.fnamemodify(vim.fn.expand(current_skel), ':p:t:r')
            mappings['*.' .. filename] = current_skel
        end

        skel.setup({
            skel_enabled = true,
            apply_skel_for_empty_file = true,

            substitutions = {
                ['SIMPLE_FILENAME'] = simple_filename,
                ['FILENAME'] = skeld.get_filename,
                ['NAME'] = skeld.get_author,
                ['DATE'] = skeld.get_date,
                ['CPP_HDR_GUARD'] = skeld.get_cppheaderguard,
                ['CPP_TEST_HDR_GUARD'] = skeld.get_testheaderguard,
                ['CPP_HDR_INCLUDE'] = skeld.get_headerinclude,
                ['CLASS_NAME'] = skeld.get_classname2,
                ['NAMESPACE_OPEN'] = skeld.get_namespaceopen,
                ['NAMESPACE_CLOSE'] = skeld.get_namespaceclose,
            },

            templates_dir = require('core.info').path_skel_templates,
            mappings = mappings,
        })
    end,
}
