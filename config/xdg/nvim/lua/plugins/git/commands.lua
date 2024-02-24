local utils = require('plugins.git.utils')

local function command(desc, name, cb, opts)
  opts = opts or {}
  opts.desc = 'git: ' .. desc

  vim.api.nvim_create_user_command('Git' .. name, function(cmdopts)
    cb(cmdopts)
  end, opts)
end

return {
  setup = function(gitsigns)
    command('open origin in the browser', 'BrowseRepository', utils.open_repository_url)

    command('open merge request in the browser', 'BrowseMergeRequest', function()
      vim.fn.jobstart({ 'git-browse-merge-request' })
    end)

    command('open remote file in the browser', 'BrowseFileRemoteUrl', function(cmd)
      utils.open_remote_url(cmd.args)
    end, { nargs = '?' })

    command('copy remote file url', 'CopyFileRemoteURL', function(cmd)
      utils.copy_remote_url(cmd.args)
    end, { nargs = '?', bang = true })

    command('open diff in a split view', 'Diff', function(cmd)
      gitsigns.diffthis(cmd.args)
    end, { nargs = '?' })

    command('blame current line', 'Blame', function()
      gitsigns.blame_line({ full = true, ignore_whitespace = true })
    end)

    command('restore file to last committed version', 'Restore', function()
      vim.cmd('execute "!git restore -- %" | mode')
    end, { nargs = '?' })

    command('reset file to HEAD or given tree', 'Reset', function(cmd)
      local tree = cmd.args ~= '' and cmd.args or 'HEAD'

      vim.cmd(string.format('execute "!git reset %s -- %%" | mode', tree))
    end, { nargs = '?' })

    command('add diff to stage', 'Write', function()
      local file = vim.fn.expand('%:.')
      vim.cmd('update!')
      utils.git('add ' .. file)
    end)

    vim.cmd.cabbrev('Ga GitWrite')
    vim.cmd.cabbrev('ga GitWrite')
    vim.cmd.cabbrev('Gblame GitBlame')
    vim.cmd.cabbrev('gblame GitBlame')
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
