vim.my = {}
vim.my.buffers = require('my.buffers')
vim.my.reloader = require('my.reloader')
vim.my.snippets = require('my.snippets')
vim.my.utils = require('my.utils')

require('my.commands')
require('my.diagnostic')
require('my.keymaps')
require('my.options')