local function git(cmd, callback)
  if type(cmd) == 'string' then
    cmd = vim.split(cmd, ' ')
  end
  table.insert(cmd or {}, 1, 'git')
  local output = vim.system(cmd):wait()
  local stdout = vim.trim(output.stdout)

  if callback ~= nil then
    return callback(stdout)
  else
    return stdout
  end
end

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

    local ref = git(cmd)

    if ref ~= '' then
      return ref
    end
  end

  return git('branch-main')
end

local function repository_url()
  return git('remote get-url origin', function(url)
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

local gitsigns = require('gitsigns')

local M = {
  blame = gitsigns.blame,
  git = git,
  preview_hunk = gitsigns.preview_hunk,
  reset_buffer = gitsigns.reset_buffer,
  reset_hunk = gitsigns.reset_hunk,
  stage_buffer = gitsigns.stage_buffer,
  stage_hunk = gitsigns.stage_hunk,
}

function M.prev_hunk()
  gitsigns.prev_hunk()
  vim.cmd.normal('zz')
end

function M.next_hunk()
  gitsigns.next_hunk()
  vim.cmd.normal('zz')
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

function M.diff_this(ref)
  if not ref or ref == '' then
    ref = git('branch-main')
  end

  gitsigns.diffthis(ref, { vertical = true, split = 'rightbelow' })
end

function M.open_new_files()
  git('ls-files --others --exclude-standard', function(files)
    for _, file in ipairs(vim.split(files, '\n', { trimempty = true })) do
      vim.cmd.tabnew(file)
    end
  end)
end

return M
