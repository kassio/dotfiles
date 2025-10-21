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
  setup = function()
    command('BrowseRepository', utils.open_repository_url, { desc = 'open origin in the browser' })
    command('Blame', utils.blame, { desc = 'blame file' })
    command('OpenNewFiles', utils.open_new_files, { desc = 'open unstaged files' })
    command('ResetBuffer', utils.reset_buffer, { desc = 'restore current file' })

    command('BrowseMergeRequest', function()
      vim.fn.jobstart({ 'git-browse-merge-request' })
    end, { desc = 'open merge request in the browser' })

    command('BrowseFileRemoteUrl', function(cmd)
      utils.open_remote_url(cmd.args)
    end, { nargs = '?', desc = 'open remote file in the browser' })

    command('CopyFileRemoteURL', function(cmd)
      utils.copy_remote_url(cmd.args)
    end, { nargs = '?', bang = true, desc = 'copy remote file url' })

    vim.cmd.cabbrev('Gblame Git blame')
    vim.cmd.cabbrev('Gd Gvdiffsplit')
    vim.cmd.cabbrev('Grt GitResetBuffer')
    vim.cmd.cabbrev('Gw Gwrite')
  end,
}
