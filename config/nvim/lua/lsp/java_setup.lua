local M = {}

local JDTLS_CACHE_DIR = vim.fn.stdpath('cache') .. '/nvim-jdtls'
local JDTLS_LAUNCHER_PATH = '/plugins/org.eclipse.equinox.launcher_*.jar'
local DAP_LAUNCHER_PATH = '/extension/server/com.microsoft.java.debug.plugin-*.jar'
local JAVATEST_LAUNCHER_PATH = '/extension/server/*.jar'
local JAVA_CWD_FILES = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }

local dap = require('dap')
local func = require('core.functions')
local info = require('core.info')
local jdtls = require('jdtls')
local jdtls_dap = require('jdtls.dap')
local jdtls_tests = require('jdtls.tests')
local mason_registry = require('mason-registry')

local lombok_path = ''
local jdtls_install = ''
local dap_install = ''
local platform_config = ''
local java_installation = {}
local jdtls_bundles = {}

local features = {
    dap = false,
    lsp = false,
    javatest = false,
}

local jdtls_root = jdtls.setup.find_root(JAVA_CWD_FILES)
local rooter_root = require('core.functions').cwd_root_rooter()
local find_root_fs_root = require('core.functions').find_root_fs(JAVA_CWD_FILES)

local function resolve_java_install_unix()
    -- From OS ENV
    java_installation.jdk_path = os.getenv('JAVA_HOME')
    if java_installation.jdk_path then
        java_installation.bin = java_installation.jdk_path .. '/bin'
    end

    -- From ASDF if exists
    if vim.fn.executable('asdf') == 1 then
        vim.schedule(function()
            java_installation.name = vim.fn.system('asdf list java'):match('*(%w+-%d+.%d+.%d++?%w*)')
            java_installation.jdk_path = vim.fn.system('asdf where java'):gsub('\n', '')
            java_installation.bin = java_installation.jdk_path .. '/bin'
        end)
    end

    return java_installation
end

local function resolve_dap_install()
    if mason_registry.has_package('java-debug-adapter') then
        dap_install = vim.fn.expand('$MASON/packages/java-debug-adapter')
        local java_debug_bundle = vim.split(vim.fn.glob(dap_install .. DAP_LAUNCHER_PATH), '\n')

        if func.is_str_not_blank(java_debug_bundle[1]) then
            vim.list_extend(jdtls_bundles, java_debug_bundle)
            features.dap = true
        else
            vim.notify('JAVA-DEBUG NOT FOUND!')
        end
    end
end

local function resolve_javatest_install()
    if mason_registry.has_package('java-test') then
        local java_test_path = vim.fn.expand('$MASON/packages/java-test')
        local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. JAVATEST_LAUNCHER_PATH), '\n')

        if func.is_str_not_blank(java_test_bundle[1]) then
            vim.list_extend(jdtls_bundles, java_test_bundle)
            features.javatest = true
        else
            vim.notify('JAVA-TEST NOT FOUND!')
        end
    end
end

local function resolve_java_install_win()
    -- From OS ENV
    local os_java_home = os.getenv('JAVA_HOME')
    java_installation.jdk_path = string.sub(os_java_home, 1, os_java_home:match('^.*()\\'))
    java_installation.bin = java_installation.jdk_path .. '/bin'

    return java_installation
end

local function resolve_jdtls_install()
    if mason_registry.has_package('jdtls') then
        jdtls_install = vim.fn.expand('$MASON/packages/jdtls')
        lombok_path = vim.fn.expand('$MASON/share/jdtls/lombok.jar')
    end

    if info.has_tool('jdtls') then
        jdtls_install = info.get_tool_path('jdtls')

        if info.has_tool('lombok') then
            lombok_path = info.get_tool_path('lombok')
        end
    end
end

M.config = function()
    local config_keys = {}

    if func.is_str_blank(jdtls_install) then
        vim.notify('JDTLS IS NOT YET INSTALLED!')
        return nil
    end

    if func.is_str_blank(platform_config) then
        vim.notify('PLATFORM CONFIG EMPTY!')
        return nil
    end

    if func.is_str_blank(java_installation) then
        vim.notify('JAVA NOT FOUND!')
        return nil
    end

    features.lsp = true

    config_keys.data_dir = JDTLS_CACHE_DIR
    config_keys.lombok_agent = lombok_path
    config_keys.launcher_jar = vim.fn.glob(jdtls_install .. JDTLS_LAUNCHER_PATH)

    config_keys.java_home = java_installation.jdk_path
    config_keys.java_bin = java_installation.bin
    config_keys.platform_config = platform_config

    local jdk_17_path = java_installation.jdk_path
    if jdk_17_path[1] ~= '' then
        config_keys.jdk_17_home = jdk_17_path[1]
    end

    if vim.fn.has('win32') == 1 then
        config_keys.java_bin = config_keys.jdk_17_home('\\bin\\java')
    end

    config_keys.runtimes = { {
        name = 'JavaSE-17',
        path = config_keys.jdk_17_home,
    } }

    local current_project_data_dir = config_keys.data_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local config = {
        cmd = {
            'java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-javaagent:' .. config_keys.lombok_agent,
            '-Xms4g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens',
            'java.base/java.util=ALL-UNNAMED',
            '--add-opens',
            'java.base/java.lang=ALL-UNNAMED',
            '-jar',
            config_keys.launcher_jar,
            '-configuration',
            platform_config,
            '-data',
            current_project_data_dir,
        },
        single_file_support = true,
        workspaceFolders = {
            rooter_root or jdtls_root or find_root_fs_root,
        },
        settings = {
            java = {
                project = {
                    referencedLibraries = vim.split(os.getenv('CLASSPATH') or '', ':'),
                },
                configuration = {
                    updateBuildConfiguration = 'interactive',
                    runtimes = config_keys.runtimes,
                },
                saveActions = {
                    organizeImports = true,
                },
                edit = {
                    smartSemicolonDetection = {
                        enabled = true,
                    },
                },
                postfix = {
                    enabled = true,
                },
                telemetry = {
                    enabled = false,
                },
                eclipse = {
                    downloadSources = true,
                },
                maven = {
                    downloadSources = true,
                },
                implementationsCodeLens = {
                    enabled = true,
                },
                referencesCodeLens = {
                    enabled = true,
                },
                format = {
                    enabled = true,
                },
                signatureHelp = {
                    description = {
                        enabled = false,
                    },
                    enabled = true,
                },
                completion = {
                    favoriteStaticMembers = {
                        'org.hamcrest.MatcherAssert.assertThat',
                        'org.hamcrest.Matchers.*',
                        'org.hamcrest.CoreMatchers.*',
                        'org.mockito.ArgumentMatchers.*',
                        'org.junit.jupiter.api.Assertions.*',
                        'java.util.Objects.*',
                        'org.mockito.Mockito.*',
                        'MockMvcBuilders.*',
                        'MockMvcRequestBuilders.*',
                        'MockMvcResultMatchers.*',
                        'MockMvcResultHandlers.*',
                        'MockRestRequestMatchers.*',
                        'MockRestResponseCreators.*',
                        'MockRestResponseCreators.*',
                    },
                },
                contentProvider = {
                    preferred = 'fernflower',
                },
            },
            extendedClientCapabilities = jdtls.extendedClientCapabilities,
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                },
                useBlocks = true,
            },
        },
        root_dir = rooter_root or jdtls_root or find_root_fs_root,
        on_attach = function()
            jdtls_dap.setup_dap_main_class_configs()
            jdtls.setup_dap({ hotcodereplace = 'auto' })
        end,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        init_options = {
            bundles = jdtls_bundles,
            extendedClientCapabilities = jdtls.extendedClientCapabilities,
        },
    }

    return config, features
end

local nmap = require('core.keymaps').nmap
local imap = require('core.keymaps').imap
local nimap = require('core.keymaps').multi('ni')
local nvmap = require('core.keymaps').multi('nv')
local opts = { noremap = true, silent = true, buffer = true }

local LAST_ARGS = ''
local LAST_JVM_ARGS = ''

local function update_args()
    vim.ui.input({ prompt = 'Application args:', default = LAST_ARGS }, function(input)
        if input then
            LAST_ARGS = input
        end
    end)
    return LAST_ARGS
end

local function update_jvm_args()
    vim.ui.input({ prompt = 'Jvm args:', default = LAST_JVM_ARGS }, function(input)
        if input then
            LAST_JVM_ARGS = input
        end
    end)
    return LAST_JVM_ARGS
end

local function map_wrappers()
    local wrappers = {
        ['<A-u>r'] = {
            text = 'Optional<>',
            modes = 'inv',
        },
        ['<A-u>O'] = {
            text = 'Optional.of()',
            modes = 'inv',
        },
        ['<A-u>o'] = {
            text = 'Optional.ofNullable()',
            modes = 'inv',
        },
        ['<A-u>as'] = {
            text = 'Arrays.toString()',
            modes = 'in',
        },
        ['<A-u>s'] = {
            text = 'Arrays.stream()',
            modes = 'in',
        },
        ['<A-u>j'] = {
            text = 'if ()',
            modes = 'i',
            i = {
                motion = 'caW',
                suffix = 'la {<Enter>',
            },
        },
        ['<A-u>l'] = {
            text = '() -> {}',
            modes = 'inv',
            i = { suffix = 'F{a<Enter><End>', motion = 'cia' },
            n = { suffix = 'F{a<Enter><Esc>$', motion = 'cia' },
            v = { suffix = 'F{a<Enter><A-n>' },
        },
        ['<A-u>i'] = {
            text = '() ->  ',
            modes = 'inv',
            n = { motion = 'cia' },
            i = { motion = 'cia' },
        },
        ['<A-u>\''] = {
            text = '""',
            modes = 'inv',
        },
    }

    require('core.keymaps').map_wrapper(wrappers)
end

M.attachDapKeymapsToBuf = function()
    nmap('<A-c>', function()
        if jdtls_dap.setup_dap_main_class_configs then
            vim.cmd.wa()
            jdtls_dap.setup_dap_main_class_configs({
                config_overrides = {
                    vmArgs = LAST_JVM_ARGS,
                    args = LAST_ARGS,
                },
                on_ready = dap.continue,
            })
        end
    end, 'Dap continue')

    nmap('<A-q>', function()
        update_args()
        update_jvm_args()
    end, 'Set JVM and Application args')
end

M.attachLspKeymapsToBuf = function()
    nmap('<A-C>', jdtls.extract_constant, 'Extract constant', opts)
    nmap('<A-V>', jdtls.extract_variable, 'Extract variable', opts)
    nmap('<A-v>', jdtls.extract_variable_all, 'Extract variable', opts)
    nvmap('<A-M>', jdtls.extract_method, 'Extract method', opts)
    nmap('<A-O>', jdtls.organize_imports, 'Organize imports', opts)
    nmap('<leader>aar', jdtls.set_runtime, 'Set java runtime', opts)
    nmap('<leader>aap', jdtls.super_implementation, 'Super implementation', opts)

    nmap('<leader>aau', function()
        jdtls.update_project_config()
        if jdtls_dap.setup_dap_main_class_configs then
            jdtls_dap.setup_dap_main_class_configs()
        end
    end, 'Update project config', opts)

    imap('<A-w>', function()
        vim.schedule(function()
            func.insert_at_end(';', '<Esc><Esc>i')
        end)
        jdtls.extract_variable()
    end, 'Extract and rename new object', opts)

    nimap('<A-;>', function()
        func.insert_at_end(';')
    end, 'Insert ; at the end of the line', opts)

    nmap('<leader>L', function()
        func.insert_at_start('final ')
    end, 'Insert final at the start of the line', opts)

    imap('<A-r>', function()
        func.insert_at_start('return ', true, 'i')
    end, 'Insert return at the start of the line')

    imap('<A-o>', function()
        func.insert_at_start('final ', true, 'i')
    end, 'Insert final at the start of the line')

    map_wrappers()
end

M.attachTestKeymapsToBuf = function()
    nmap('<A-t>', function()
        vim.cmd.wa()
        jdtls.test_nearest_method()
    end, 'Test nearest method')

    nmap('<leader>aat', function()
        vim.cmd.wa()
        jdtls.test_class()
    end, 'Test class')

    nmap('<leader>aas', jdtls_tests.goto_subjects, 'Goto subjects')
    nmap('<leader>aag', jdtls_tests.generate, 'Generate tests')
end

M.setup = function()
    resolve_jdtls_install()
    resolve_dap_install()
    resolve_javatest_install()

    if vim.fn.has('unix') == 1 then
        resolve_java_install_unix()
        platform_config = jdtls_install .. '/config_linux'
    elseif vim.fn.has('win32') == 1 then
        resolve_java_install_win()
        platform_config = jdtls_install .. '/config_win'
    end
end

return M
