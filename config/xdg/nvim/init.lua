-- global functions
require('globals')
-- lua extensions
require('extensions')

-- my own set of configs and helpers (plugin independent)
require('config.options')
require('config.keymaps')
require('config.commands')
require('config.diagnostic')

require('plugins.lazy')

require('plugins.session')
require('plugins.hbar')
require('plugins.focus')
