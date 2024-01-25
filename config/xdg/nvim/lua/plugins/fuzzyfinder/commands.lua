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

function M.find_rails(dirs)
  dirs = dirs or {}

  local title = 'rails'
  if #dirs > 0 then
    title = string.format('rails (%s)', table.concat(dirs, ', '))
  end

  if vim.fn.filereadable('Gemfile') > 0 then
    M.find_files({
      find_command = find_command_rails,
      search_dirs = dirs,
      prompt_title = title,
    })
  else
    M.find_files()
  end
end

return setmetatable(M, {
  __index = function(_table, key)
    return function(opts)
      require('telescope.builtin')[key](opts)
    end
  end,
})
