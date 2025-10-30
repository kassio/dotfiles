local git = require('plugins.git.utils')

local function command(name, callback, opts)
  opts = opts or {}
  if opts.desc then
    opts.desc = 'git: ' .. opts.desc
  end
  name = 'Git' .. name

  vim.api.nvim_create_user_command(name, callback, opts)
end

return {
  setup = function()
    command('BrowseRepository', git.open_repository_url, { desc = 'open origin in the browser' })
    command('Blame', git.blame, { desc = 'blame file' })
    command('OpenNewFiles', git.open_new_files, { desc = 'open unstaged files' })
    command('ResetBuffer', git.reset_buffer, { desc = 'restore current file' })
    command('Write', git.stage_buffer, { desc = 'restore current file' })

    command('Diff', function(cmd)
      git.diff_this(cmd.args)
    end, { nargs = '?', desc = 'diff this file with given ref or main' })

    command('BrowseMergeRequest', function()
      vim.fn.jobstart({ 'git-browse-merge-request' })
    end, { desc = 'open merge request in the browser' })

    command('BrowseFileRemoteUrl', function(cmd)
      git.open_remote_url(cmd.args)
    end, { nargs = '?', desc = 'open remote file in the browser' })

    command('CopyFileRemoteURL', function(cmd)
      git.copy_remote_url(cmd.args)
    end, { nargs = '?', bang = true, desc = 'copy remote file url' })

    vim.cmd.cabbrev('Gblame GitBlame')
    vim.cmd.cabbrev('Gd GitDiff')
    vim.cmd.cabbrev('Grt GitResetBuffer')
    vim.cmd.cabbrev('Gw Gwrite')
  end,
}
