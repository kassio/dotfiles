return {
  setup = function(ffinder)
    vim.keymap.set('n', '<leader>fg', function()
      local main = vim.system({ 'git-branch-main' }):wait().stdout or ''
      local git_diff = [[git --no-pager diff --diff-filter=AMRUX --name-only --relative %s]]
      local modified = string.format(git_diff, 'HEAD')
      local changed = string.format(git_diff, vim.trim(main) .. '...')
      local untracked = [[git --no-pager ls-files --others --exclude-standard]]
      local command = string.format("{ %s; %s; %s; } | sort -u", modified, changed, untracked)

      ffinder.git_files({
        silent = true,
        cwd = vim.uv.cwd(),
        prompt = "git:diff> ",
        cmd = command,
      })
    end, { desc = 'find:git:diff' })
  end
}
