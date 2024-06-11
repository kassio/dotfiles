local M = {}

local function open(url)
  vim.ui.open(url)
end

local function get_filepath()
  local filename = vim.fn.expand('%:p')
  local root = vim.fs.root(filename, '.git')

  return string.gsub(filename, '^' .. root .. '/', '')
end

-- Tries to get git ref for the given file/line
-- If not found return the main branch
-- Also returns the main branch if the third parameter is true
local function get_ref(file, line, use_main)
  if not use_main then
    local pathspec = string.format('-L "%s,%s:%s"', line, line, file)
    local cmd = string.format('log -1 --no-patch --pretty=format:"%%H" %s', pathspec)

    local ref = M.git(cmd)

    if ref ~= '' then
      return ref
    end
  end

  return M.git('branch-main')
end

local function repository_url()
  return M.git('remote get-url origin', function(url)
    url = string.gsub(url, '^git@', 'https://')
    url = string.gsub(url, '%.git$', '')

    return url
  end)
end

local function file_remote_url(arg)
  local use_main = arg == 'main' or arg == 'master'
  local filepath = get_filepath()
  local line = vim.fn.line('.')
  local ref = get_ref(filepath, line, use_main)

  return (string.format('%s/blob/%s/%s#L%s', repository_url(), ref, filepath, line))
end

function M.git(cmd, callback)
  table.insert(cmd or {}, 1, 'git')
  local output = vim.system(cmd):wait()
  local stdout = vim.trim(output.stdout)

  if callback ~= nil then
    return callback(stdout)
  else
    return stdout
  end
end

function M.open_repository_url()
  open(repository_url())
end

function M.open_remote_url(arg)
  open(file_remote_url(arg))
end

function M.copy_remote_url(arg)
  open(file_remote_url(arg))
end

return M
