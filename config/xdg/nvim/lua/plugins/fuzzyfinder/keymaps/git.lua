return {
  setup = function(keymap)
    return {
      keymap('gg', require('plugins.fuzzyfinder.commands').git_files, 'git:files'),
      keymap('gm', function()
        local main = vim.fn.system('git-branch-main')

        require('plugins.fuzzyfinder.commands').find_files({
          find_command = {
            'git',
            'diff',
            '--name-only',
            '--relative',
            string.format('%s...', vim.trim(main)),
          },
          prompt_title = 'git:main',
        })
      end, 'git:main'),
      keymap('gd', function()
        require('plugins.fuzzyfinder.commands').find_files({
          find_command = { 'git', 'ls-files', '--modified' },
          prompt_title = 'git:diff',
        })
      end, 'git:diff'),
    }
  end,
}
