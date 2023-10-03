local M = {}

M.find = {
  'fd',
  '--type',
  'file',
  '--type',
  'symlink',
  '--hidden',
  '--no-ignore-vcs',
  '--color',
  'never',
  '--exclude',
  '*.png',
  '--exclude',
  '*.jpeg',
  '--exclude',
  '*.gif',
}

M.find_ruby = require('utils.table').join_lists(M.find, {
  '--extension',
  'rb',
  '--extension',
  'haml',
  '--extension',
  'erb',
})

return M
