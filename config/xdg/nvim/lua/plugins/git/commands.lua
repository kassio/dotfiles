local function command(name, cb, opts)
  local desc = opts.desc
  opts.desc = 'git: ' .. desc

  vim.api.nvim_create_user_command('Git' .. name, function(cmdopts)
    cb(cmdopts)
  end, opts)
end

return {
  setup = function(gitsigns)
    local utils = require('plugins.git.utils')

    command('BrowseRepository', utils.open_repository_url, {
      desc = 'open origin in the browser',
    })

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
      gitsigns.blame_line({ full = true, ignore_whitespace = true })
    end, { desc = 'blame current line' })

    command('Restore', function()
      vim.cmd('execute "!git restore -- %" | mode')
    end, { nargs = '?', desc = 'restore file to last committed version' })

    command('Reset', function(cmd)
      local tree = cmd.args ~= '' and cmd.args or 'HEAD'

      vim.cmd('execute "!git reset ' .. tree .. ' -- %" | mode')
    end, { nargs = '?', desc = 'reset file to HEAD or given tree' })

    command('Write', function()
      local file = vim.fn.expand('%:.')
      vim.cmd('update!')
      utils.git('add ' .. file)
    end, { desc = 'add diff to stage' })

    vim.cmd.cabbrev('Ga GitWrite')
    vim.cmd.cabbrev('Gblame GitBlame')
    vim.cmd.cabbrev('Gd GitDiff')
    vim.cmd.cabbrev('Gdm GitDiff main')
    vim.cmd.cabbrev('Grt GitRestore')
    vim.cmd.cabbrev('Grt GitRestore')
    vim.cmd.cabbrev('Gw GitWrite')
  end,
}
