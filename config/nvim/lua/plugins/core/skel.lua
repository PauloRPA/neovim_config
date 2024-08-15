return {
    'motosir/skel-nvim',
    config = function()
        local skel = require('skel-nvim')
        local skeld = require('skel-nvim.defaults')

        skel.setup({
            skel_enabled = true,
            apply_skel_for_empty_file = true,

            substitutions = {
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
            mappings = {
                -- ['*.java'] = 'java.skel',
            },
        })
    end,
}
