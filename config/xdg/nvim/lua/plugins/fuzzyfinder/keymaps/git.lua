return {
  setup = function(keymap)
    return {
      keymap('gg', 'git:files', require('plugins.fuzzyfinder.commands').git_files),
      keymap('gm', 'git:diff', function()
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
      keymap('gd', 'git:modified', function()
        require('plugins.fuzzyfinder.commands').find_files({
          find_command = { 'git', 'ls-files', '--modified' },
          prompt_title = 'git:modified',
        })
      end),
    }
  end,
}
