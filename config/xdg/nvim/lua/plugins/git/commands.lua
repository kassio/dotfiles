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

    command('BrowseMergeRequest', function()
      vim.fn.jobstart({ 'git-browse-merge-request' })
    end, { desc = 'open merge request in the browser' })

    command('BrowseFileRemoteUrl', function(cmd)
      utils.open_remote_url(cmd.args)
    end, { nargs = '?', desc = 'open remote file in the browser' })

    command('CopyFileRemoteURL', function(cmd)
      utils.copy_remote_url(cmd.args)
    end, { nargs = '?', bang = true, desc = 'copy remote file url' })

    command('Blame', function()
      vim.cmd.Git('blame')
    end, { desc = 'blame file' })

    command('Diff', function(cmd)
      vim.cmd('leftabove Gdiffsplit ' .. cmd.args)
    end, { nargs = '*', desc = 'open the file diff' })

    command('OpenNewFiles', function()
      utils.git('ls-files --others --exclude-standard', function(files)
        for _, file in ipairs(vim.split(files, '\n', { trimempty = true })) do
          vim.cmd.tabnew(file)
        end
      end)
    end, { desc = 'open unstaged files' })

    vim.cmd.cabbrev('Gblame Git blame')
    vim.cmd.cabbrev('Gd Gvdiffsplit')
    vim.cmd.cabbrev('Grt Git restore %')
    vim.cmd.cabbrev('Gw Gwrite')
  end,
}
