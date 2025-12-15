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
    command('OpenNewFiles', git.open_new_files, { desc = 'open unstaged files' })

    command('Blame', git.blame, { desc = 'blame file' })
    vim.cmd.cabbrev('Gb GitBlame')

    command('ResetBuffer', git.reset_buffer, { desc = 'restore current file' })
    vim.cmd.cabbrev('Grt GitResetBuffer')

    command('Write', git.stage_buffer, { desc = 'restore current file' })
    vim.cmd.cabbrev('Gw GitWrite')

    command('Diff', function(cmd)
      git.diff_this(cmd.args)
    end, { nargs = '?', desc = 'diff this file with given ref or main' })
    vim.cmd.cabbrev('Gd GitDiff')

    command('DiffClose', function ()
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf = vim.api.nvim_win_get_buf(win)
        local name = vim.api.nvim_buf_get_name(buf)

        if name:match("^gitsigns://") then
          vim.api.nvim_win_close(win, true)
        end
      end
    end, { desc = 'close diff windows on current tab' })
    vim.cmd.cabbrev('Gdc GitDiffClose')

    command('BrowseMergeRequest', function()
      vim.fn.jobstart({ 'git-browse-merge-request' })
    end, { desc = 'open merge request in the browser' })

    command('BrowseFileRemoteUrl', function(cmd)
      git.open_remote_url(cmd.args)
    end, { nargs = '?', desc = 'open remote file in the browser' })

    command('CopyFileRemoteURL', function(cmd)
      git.copy_remote_url(cmd.args)
    end, { nargs = '?', bang = true, desc = 'copy remote file url' })

  end,
}
