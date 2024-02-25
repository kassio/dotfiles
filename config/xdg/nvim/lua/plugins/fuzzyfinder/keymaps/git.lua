local function gitmap(keymap, key, name, cb, opts)
  return keymap(key, table.concat({ 'git', name }, ':'), cb, opts)
end

return {
  setup = function(keymap)
    return {
      gitmap(keymap, 'gg', 'files', require('plugins.fuzzyfinder.commands').git_files),
      gitmap(keymap, 'gm', 'diff', function()
        local main = vim.fn.system('git-branch-main')

        require('plugins.fuzzyfinder.commands').find_files({
          find_command = {
            'git',
            'diff',
            '--name-only',
            '--relative',
            string.format('%s...', vim.trim(main)),
          },
          prompt_title = 'git:diff',
        })
      end),
      gitmap(keymap, 'gd', 'modified', function()
        require('plugins.fuzzyfinder.commands').find_files({
          find_command = { 'git', 'ls-files', '--modified' },
          prompt_title = 'git:modified',
        })
      end),
    }
  end,
}
