-- my own set of configs and helpers (plugin independent)
require('config.options')
require('config.filetype')
require('config.keymaps')
require('config.commands')
require('config.signs')

require('config.session')
require('config.status')

require('config.ui').setup()
require('config.focus').setup()
require('config.diagnostics').setup()
require('config.terminal').setup()

-- plugins
require('config.plugins')

-- User Tick autocommand (1s ticker)
require('config.ticker').setup()
