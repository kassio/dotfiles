return {
  setup = function(keymap)
    return {
      keymap('gg', require('plugins.fuzzyfinder.commands').git_files, 'git:files'),
      keymap('gm', function()
        local output = vim.system({ 'git-branch-main' }):wait()
        local main = output.stdout or ''
        main = vim.trim(main)

        require('plugins.fuzzyfinder.commands').find_files({
          find_command = {
            'git',
            'diff',
            '--diff-filter=d',
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
