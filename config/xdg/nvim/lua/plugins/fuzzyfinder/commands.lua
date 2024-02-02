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

function M.find_files(opts)
  opts = opts or {}

  local finder = find_command
  local title = 'find files'

  if opts['extensions'] ~= nil then
    local extensions = vim.tbl_flatten({ opts.extensions })
    opts.extensions = nil

    finder = vim.fn.reduce(extensions, function(result, ext)
      table.insert(result, '--extension')
      table.insert(result, ext)
      return result
    end, find_command)

    title = string.format('%s (%s)', title, table.concat(extensions, ', '))
  end

  local new_opts = vim.tbl_deep_extend('keep', opts or {}, {
    find_command = finder,
    prompt_title = title,
  })

  require('telescope.builtin').find_files(new_opts)
end

function M.find_rails(dirs)
  if vim.fn.filereadable('Gemfile') <= 0 then
    M.find_files()
    return
  end

  dirs = dirs or {}

  local title = 'rails'
  if #dirs > 0 then
    title = string.format('rails (%s)', table.concat(dirs, ', '))
  end

  M.find_files({
    extensions = { 'rb', 'haml', 'erb' },
    search_dirs = dirs,
    prompt_title = title,
  })
end

function M.current_dir(opts)
  opts = opts or {}
  local path = vim.tbl_get(opts, 'search_dirs', 1) or '.'

  M.find_files(vim.tbl_deep_extend('keep', opts, {
    prompt_title = 'find in ' .. path,
    find_command = {
      'fd',
      '--max-depth',
      '1',
    },
  }))
end

return setmetatable(M, {
  __index = function(_table, key)
    return function(opts)
      require('telescope.builtin')[key](opts)
    end
  end,
})
