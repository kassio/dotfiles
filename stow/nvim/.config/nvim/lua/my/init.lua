vim.my = {}
vim.my.buffers = require('my.buffers')
vim.my.reloader = require('my.reloader')
vim.my.sessions = require('my.sessions')
vim.my.snippets = require('my.snippets')
vim.my.theme = require('my.theme')
vim.my.utils = require('my.utils')
vim.my.windows = require('my.windows')

require('my.autocommands')
require('my.commands')
require('my.diagnostic')
require('my.keymaps')
require('my.options')
