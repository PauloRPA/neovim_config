-- Core
require('core.options').load()
require('core.keymaps').load()
require('core.autocmds').load()
require('core.editor').load()

-- Bootstrap plugin manager
require('core.bootstrap').load()
require('lsp.java_setup').setup()
