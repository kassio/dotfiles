-- my own set of configs and helpers (plugin independent)
require('config.options')
require('config.filetype')
require('config.keymaps')
require('config.commands')
require('config.signs')

require('config.session').setup()
require('config.diagnostics').setup()
require('config.focus').setup()
require('config.status').setup()
require('config.terminal').setup()

-- plugins
require('config.plugins')
