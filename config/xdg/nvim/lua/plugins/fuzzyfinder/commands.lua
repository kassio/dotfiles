local M = {}
local default_find_command = {
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
  '.git',
  '--exclude',
  '*.png',
  '--exclude',
  '*.jpeg',
  '--exclude',
  '*.gif',
}

local function find_command(extra)
  return vim.fn.reduce(extra, function(result, ext)
    table.insert(result, '--extension')
    table.insert(result, ext)
    return result
  end, default_find_command)
end

function M.find_files(opts)
  opts = opts or {}

  local extensions = vim.tbl_flatten({ opts.extensions })
  opts.extensions = nil

  local title = 'find files'
  if #extensions == 1 then
    title = string.format('find *.%s', extensions[1])
  elseif #extensions > 1 then
    title = string.format('find [%s]', table.concat(extensions, ', '))
  end

  local search_dirs = vim.tbl_flatten({ opts.search_dirs })
  if #search_dirs > 0 then
    title = string.format('%s in (%s)', title, table.concat(search_dirs, ', '))
  end

  local new_opts = vim.tbl_deep_extend('keep', opts or {}, {
    find_command = find_command(extensions),
    search_dirs = search_dirs,
    prompt_title = title,
  })

  return require('telescope.builtin').find_files(new_opts)
end

function M.find_rails(search_dirs)
  M.find_files({
    extensions = { 'rb', 'haml', 'erb' },
    search_dirs = search_dirs,
  })
end

function M.current_dir(opts)
  opts = opts or {}
  local path = vim.tbl_get(opts, 'search_dirs', 1) or '.'

  M.find_files(vim.tbl_deep_extend('keep', opts, {
    _type = 'current_dir',
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
