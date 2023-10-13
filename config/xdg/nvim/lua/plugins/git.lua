return {
  'lewis6991/gitsigns.nvim',
  config = function()
    local gitsigns = require('gitsigns')
    local fn = vim.fn
    local command = vim.api.nvim_create_user_command
    local keymap = vim.keymap.set
    local utils = require('utils')

    local open = function(url)
      vim.ui.open(url)
    end

    local git = function(args, callback)
      local output = vim.trim(fn.system('git ' .. args .. ' 2>/dev/null'))

      if callback ~= nil then
        return callback(output)
      else
        return output
      end
    end

    local get_repository_url = function()
      return git('remote get-url origin', function(url)
        url = string.gsub(url, '^git@', 'https://')
        url = string.gsub(url, '%.git$', '')

        return url
      end)
    end

    -- Tries to get git ref for the given file/line
    -- If not found return the main branch
    -- Also returns the main branch if the third parameter is true
    local get_ref = function(file, line, use_main)
      if not use_main then
        local pathspec = string.format('-L "%s,%s:%s"', line, line, file)
        local cmd = string.format('log -1 --no-patch --pretty=format:"%%H" %s', pathspec)

        local ref = git(cmd)

        if ref ~= '' then
          return ref
        end
      end

      return git('branch-main')
    end

    local get_remote_url = function(file, line, use_main)
      local ref = get_ref(file, line, use_main)
      local repository_url = get_repository_url()

      return string.format('%s/blob/%s/%s#L%s', repository_url, ref, file, line)
    end

    gitsigns.setup({
      signs = {
        add = { text = '▎' },
        untracked = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '▎' },
        topdelete = { text = '‾' },
        changedelete = { text = '_' },
      },
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align',
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author> - <summary>, <author_time:%Y%m%d>',
      diff_opts = { vertical = true },
      numhl = true,
    })

    keymap('n', ']c', function()
      gitsigns.next_hunk()
      vim.cmd.normal('zz')
    end, { desc = 'git: next hunk' })

    keymap('n', '[c', function()
      gitsigns.prev_hunk()
      vim.cmd.normal('zz')
    end, { desc = 'git: previous hunk' })

    keymap('n', '<c-g><c-a>', function()
      gitsigns.stage_hunk()
    end, { desc = 'git: stage hunk (add)' })

    keymap('n', '<c-g><c-d>', function()
      gitsigns.preview_hunk()
    end, { desc = 'git: preview hunk (diff)' })

    keymap('n', '<c-g><c-u>', function()
      gitsigns.reset_hunk()
    end, { desc = 'git: reset hunk (undo)' })

    keymap('n', '<c-g><c-l>', function()
      gitsigns.blame_line({ full = true, ignore_whitespace = true })
    end, { desc = 'git: blame current line' })

    command('GitBrowseRepository', function()
      open(get_repository_url())
    end, { desc = 'git: open origin in the browser' })

    command('GitBrowseMergeRequest', function()
      fn.jobstart({ 'git-browse-merge-request' })
    end, { desc = 'git: open merge request in the browser' })

    command('GitBrowseFileRemoteUrl', function(cmd)
      local use_main = cmd.args == 'main' or cmd.args == 'master'
      local file = fn.expand('%:.')
      local line = fn.line('.')

      open(get_remote_url(file, line, use_main))
    end, { nargs = '?', desc = 'git: open remote file in the browser' })

    command('GitCopyFileRemoteURL', function(cmd)
      local use_main = cmd.args == 'main' or cmd.args == 'master'
      local file = fn.expand('%:.')
      local line = fn.line('.')

      utils.to_clipboard(get_remote_url(file, line, use_main), cmd.bang)
    end, { nargs = '?', bang = true, desc = 'git: copy remote file url' })

    command('GitDiff', function(cmd)
      gitsigns.diffthis(cmd.args)
    end, { nargs = '?', desc = 'git: open diff in a split view' })

    command('GitBlame', function()
      gitsigns.blame_line({ full = true, ignore_whitespace = true })
    end, { desc = 'git: blame current line' })

    command('GitRestore', function()
      vim.cmd('execute "!git restore -- %" | mode')
    end, { nargs = '?', desc = 'git: restore file to last committed version' })

    command('GitReset', function(cmd)
      local tree = cmd.args ~= '' and cmd.args or 'HEAD'

      vim.cmd('execute "!git reset ' .. tree .. ' -- %" | mode')
    end, { nargs = '?', desc = 'git: reset file to HEAD or given tree' })

    command('GitWrite', function()
      local file = fn.expand('%:.')
      vim.cmd('update!')
      git('add ' .. file)
    end, { desc = 'git: add diff to stage' })

    vim.cmd.cabbrev('Ga GitWrite')
    vim.cmd.cabbrev('Gblame GitBlame')
    vim.cmd.cabbrev('Gd GitDiff')
    vim.cmd.cabbrev('Gdm GitDiff main')
    vim.cmd.cabbrev('Grt GitRestore')
    vim.cmd.cabbrev('Grt GitRestore')
    vim.cmd.cabbrev('Gw GitWrite')
  end,
}
