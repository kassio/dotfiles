local utils = require('plugins.git.utils')

local function command(name, callback, opts)
  opts = opts or {}
  if opts.desc then
    opts.desc = 'git: ' .. opts.desc
  end
  name = 'Git' .. name

  vim.api.nvim_create_user_command(name, callback, opts)
end

return {
  setup = function(gitsigns)
    command('BrowseRepository', utils.open_repository_url, { desc = 'open origin in the browser' })

    command('BrowseMergeRequest', function()
      vim.fn.jobstart({ 'git-browse-merge-request' })
    end, { desc = 'open merge request in the browser' })

    command('BrowseFileRemoteUrl', function(cmd)
      utils.open_remote_url(cmd.args)
    end, { nargs = '?', desc = 'open remote file in the browser' })

    command('CopyFileRemoteURL', function(cmd)
      utils.copy_remote_url(cmd.args)
    end, { nargs = '?', bang = true, desc = 'copy remote file url' })

    command('Diff', function(cmd)
      gitsigns.diffthis(cmd.args)
    end, { nargs = '?', desc = 'open diff in a split view' })

    command('Blame', function()
      vim.cmd.BlameToggle()
    end, { desc = 'blame current line' })

    command('Restore', function()
      vim.cmd('execute "!git restore -- %" | mode')
    end, { nargs = '?', desc = 'restore file to last committed version' })

    command('Reset', function(cmd)
      local tree = cmd.args ~= '' and cmd.args or 'HEAD'

      vim.cmd(string.format('execute "!git reset %s -- %%" | mode', tree))
    end, { nargs = '?', desc = 'reset file to HEAD or given tree' })

    command('Write', function()
      local file = vim.fn.expand('%:.')
      vim.cmd('update!')
      utils.git('add ' .. file)
    end, { desc = 'add diff to stage' })

    vim.cmd.cabbrev('Ga GitWrite')
    vim.cmd.cabbrev('ga GitWrite')
    vim.cmd.cabbrev('Gblame BlameToggle')
    vim.cmd.cabbrev('gblame BlameToggle')
    vim.cmd.cabbrev('Gd GitDiff')
    vim.cmd.cabbrev('gd GitDiff')
    vim.cmd.cabbrev('Gdm GitDiff main')
    vim.cmd.cabbrev('gdm GitDiff main')
    vim.cmd.cabbrev('Grt GitRestore')
    vim.cmd.cabbrev('grt GitRestore')
    vim.cmd.cabbrev('Gw GitWrite')
    vim.cmd.cabbrev('gw GitWrite')
  end,
}
