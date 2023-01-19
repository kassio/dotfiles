local gitsigns = require('gitsigns')
local fn = vim.fn
local command = vim.api.nvim_create_user_command
local utils = require('my.utils')
local colors = require('plugins.highlight.theme').colors
local hl = utils.highlights

local cabbrev = utils.cabbrev

local open = function(url)
  fn.jobstart({ 'open', url })
end

local git = function(args, callback)
  local output = vim.trim(fn.system('git ' .. args .. ' 2>/dev/null'))

  if callback ~= nil then
    return callback(output)
  else
    return output
  end
end

-- Git
hl.def('GitSignsCurrentLineBlame', {
  background = colors.mantle,
  foreground = colors.surface1,
  italic = true,
})

hl.def('GitSignAdd', { foreground = colors.hint })
hl.def('GitSignChange', { foreground = colors.warn })
hl.def('GitSignDelete', { foreground = colors.error })

local GIT = {}

GIT.get_repository_url = function()
  return git('remote get-url origin', function(url)
    url = string.gsub(url, '^git@', 'https://')
    url = string.gsub(url, '%.git$', '')

    return url
  end)
end

-- Tries to get git ref for the given file/line
--   If not found return the main branch
-- Also returns the main branch if the third parameter is true
GIT.get_ref = function(file, line, use_main)
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

GIT.get_remote_url = function(file, line, use_main)
  local ref = GIT.get_ref(file, line, use_main)
  local repository_url = GIT.get_repository_url()

  return string.format('%s/blob/%s/%s#L%s', repository_url, ref, file, line)
end

gitsigns.setup({
  signs = {
    add = { hl = 'GitSignAdd', text = '│' },
    change = { hl = 'GitSignChange', text = '│' },
    delete = { hl = 'GitSignDelete', text = '│' },
    topdelete = { hl = 'GitSignDelete', text = '‾' },
    changedelete = { hl = 'GitSignDelete', text = '│' },
  },
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'right_align',
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author> - <summary>, <author_time:%Y%m%d>',
  diff_opts = {
    vertical = true,
  },
  numhl = false,
})

local M = {
  open_remote_file = function(cmd)
    local use_main = cmd.args == 'main' or cmd.args == 'master'
    local file = fn.expand('%:.')
    local line = fn.line('.')

    open(GIT.get_remote_url(file, line, use_main))
  end,
  copy_remote_file = function(opts)
    opts = opts or {}
    local use_main = opts.ref == 'main' or opts.ref == 'master'
    local file = fn.expand('%:.')
    local line = fn.line('.')

    utils.to_clipboard(GIT.get_remote_url(file, line, use_main), opts.clipboard)
  end,
  open_repository = function()
    open(GIT.get_repository_url())
  end,
  preview_hunk = gitsigns.preview_hunk,
  blame_line = function()
    gitsigns.blame_line({ full = true, ignore_whitespace = true })
  end,
  blame_line_toggle = gitsigns.toggle_current_line_blame,
  restore = function()
    vim.cmd('execute "!git restore -- %" | mode')
  end,
  branch_current = function()
    print(vim.g.gitsigns_head)
  end,
  diff = function(cmd)
    gitsigns.diffthis(cmd.args)
  end,
  write = function()
    local file = fn.expand('%:.')
    vim.cmd('update!')
    git('add ' .. file)
  end,
}

vim.keymap.set('n', ']c', gitsigns.next_hunk)
vim.keymap.set('n', '[c', gitsigns.prev_hunk)

command('GitOpenRepository', M.open_repository, {})
command('GitOpenFileRemoteUrl', M.open_remote_file, { nargs = '?' })
command('GitCopyFileRemoteURL', M.copy_remote_file, { nargs = '?' })

command('GitDiff', M.diff, { nargs = '?' })
cabbrev('Gd', 'GitDiff')

command('GitBlameInLineToggle', M.blame_line_toggle, {})
command('GitBlame', M.blame_line, {})
cabbrev('Gblame', 'GitBlame')

command('GitPreviewHunk', M.preview_hunk, {})

command('GitRestore', M.restore, {})
cabbrev('Grt', 'GitRestore')

command('GitWrite', M.write, {})
cabbrev('Gw', 'GitWrite')
cabbrev('Ga', 'GitWrite')

command('GitBranchCurrent', M.branch_current, {})
