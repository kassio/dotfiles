return {
  setup = function(ffinder)
    -- files
    vim.keymap.set('n', '<leader>ff', ffinder.global, { desc = 'find:global' })
    vim.keymap.set('n', '<leader>fo', ffinder.oldfiles, { desc = 'find:oldfiles' })

    -- buffer
    vim.keymap.set('n', '<leader>fn', ffinder.blines, { desc = 'find:current buffer lines' })

    -- grep
    vim.keymap.set('n', '<leader>fw', ffinder.grep, { desc = 'find:grep' })

    -- git
    vim.keymap.set('n', '<leader>fg', function()
      local main = vim.system({ 'git-branch-main' }):wait().stdout or ''
      local git_diff = [[git --no-pager diff --diff-filter=AMRUX --name-only --relative %s]]
      local modified = string.format(git_diff, 'HEAD')
      local changed = string.format(git_diff, vim.trim(main))
      local untracked = [[git --no-pager ls-files --others --exclude-standard]]

      ffinder.git_files({
        cwd = vim.uv.cwd(),
        prompt = "git:diff> ",
        cmd = string.format("{ %s; %s; %s; } | sort -u", modified, changed, untracked),
      })
    end, { desc = 'find:git:diff' })

    -- others
    vim.keymap.set('n', '<leader>fh', ffinder.helptags, { desc = 'find:help' })
    vim.keymap.set('n', '<leader>fp', ffinder.resume, { desc = 'find:resume' })
  end
}
