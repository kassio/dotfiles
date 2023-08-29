-- my own set of configs and helpers (plugin independent)
require('config.autotheme').setup()
require('config.options')
require('config.filetype')
require('config.keymaps')
require('config.commands')
require('config.diagnostic')
require('config.autocmds')
require('config.signs')

-- community plugins
require('config.plugins')

-- inhouse plugins
require('config.session')
require('config.status')
