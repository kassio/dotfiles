local M = {}

local find_command = {
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

local find_command_rails = require('utils.table').join_lists(find_command, {
  '--extension',
  'rb',
  '--extension',
  'haml',
  '--extension',
  'erb',
})

function M.find_files(opts)
  require('telescope.builtin').find_files(vim.tbl_deep_extend('keep', opts or {}, {
    find_command = find_command,
  }))
end

function M.find_rails(opts)
  if vim.fn.filereadable('Gemfile') > 0 then
    M.find_files(vim.tbl_deep_extend('keep', opts or {}, {
      find_command = find_command_rails,
      search_dirs = { 'app', 'lib', 'ee/app', 'ee/lib' },
      prompt_title = 'rails (app, lib)',
    }))
  else
    M.find_files()
  end
end

function M.find_rails_tests(opts)
  M.find_rails(vim.tbl_deep_extend('keep', opts or {}, {
    search_dirs = { 'app', 'lib', 'spec', 'ee/app', 'ee/lib', 'ee/spec' },
    prompt_title = 'rails (app, lib, spec)',
  }))
end

return setmetatable(M, {
  __index = function(_table, key)
    return function(opts)
      require('telescope.builtin')[key](opts)
    end
  end,
})
