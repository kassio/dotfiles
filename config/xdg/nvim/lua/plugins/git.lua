return {
  'lewis6991/gitsigns.nvim',
  config = function()
    local gitsigns = require('gitsigns')
    local fn = vim.fn
    local command = vim.api.nvim_create_user_command
    local utils = require('utils')

    local cabbrev = utils.cabbrev

    local open = function(url)
      fn.jobstart({ 'open', url })
    end

    local git = function(args, callback)
      local output = vim.trim(fn.system('git ' .. args .. ' 2>/dev/null'))

      if callback ~= nil then
        return callback(output)
      else
        return output
      end
    end

    local GIT = {}

    GIT.get_repository_url = function()
      return git('remote get-url origin', function(url)
        url = string.gsub(url, '^git@', 'https://')
        url = string.gsub(url, '%.git$', '')

        return url
      end)
    end

    -- Tries to get git ref for the given file/line
    -- If not found return the main branch
    -- Also returns the main branch if the third parameter is true
    GIT.get_ref = function(file, line, use_main)
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

    GIT.get_remote_url = function(file, line, use_main)
      local ref = GIT.get_ref(file, line, use_main)
      local repository_url = GIT.get_repository_url()

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
      numhl = false,
    })

    local M = {
      browse_file = function(cmd)
        local use_main = cmd.args == 'main' or cmd.args == 'master'
        local file = fn.expand('%:.')
        local line = fn.line('.')

        open(GIT.get_remote_url(file, line, use_main))
      end,
      copy_remote_file = function(opts)
        opts = opts or {}
        local use_main = opts.ref == 'main' or opts.ref == 'master'
        local file = fn.expand('%:.')
        local line = fn.line('.')

        utils.to_clipboard(GIT.get_remote_url(file, line, use_main), opts.clipboard)
      end,
      browse_repository = function()
        open(GIT.get_repository_url())
      end,
      browse_merge_request = function()
        fn.jobstart({ 'git-browse-merge-request' })
      end,
      preview_hunk = gitsigns.preview_hunk,
      blame_line = function()
        gitsigns.blame_line({ full = true, ignore_whitespace = true })
      end,
      blame_line_toggle = gitsigns.toggle_current_line_blame,
      restore = function()
        vim.cmd('execute "!git restore -- %" | mode')
      end,
      branch_current = function()
        print(vim.g.gitsigns_head)
      end,
      diff = function(cmd)
        gitsigns.diffthis(cmd.args)
      end,
      write = function()
        local file = fn.expand('%:.')
        vim.cmd('update!')
        git('add ' .. file)
      end,
    }

    vim.keymap.set('n', ']c', function()
      gitsigns.next_hunk()
      vim.cmd.normal('zz')
    end, { desc = 'git: next hunk' })

    vim.keymap.set('n', '[c', function()
      gitsigns.prev_hunk()
      vim.cmd.normal('zz')
    end, { desc = 'git: previous hunk' })

    command('GitBrowseRepository', M.browse_repository, {
      desc = 'git: open origin in the browser',
    })
    command('GitBrowseMergeRequest', M.browse_merge_request, {
      desc = 'git: open merge request in the browser',
    })
    command('GitBrowseFileRemoteUrl', M.browse_file, {
      nargs = '?',
      desc = 'git: open remote file in the browser',
    })

    command('GitCopyFileRemoteURL', M.copy_remote_file, {
      nargs = '?',
      desc = 'git: copy remote file url',
    })

    command('GitDiff', M.diff, {
      nargs = '?',
      desc = 'git: open diff in a split view',
    })
    cabbrev('Gd', 'GitDiff')

    command('GitBlameInLineToggle', M.blame_line_toggle, {
      desc = 'git: toggle inline blame',
    })
    command('GitBlame', M.blame_line, {
      desc = 'git: blame current line',
    })
    cabbrev('Gblame', 'GitBlame')

    command('GitPreviewHunk', M.preview_hunk, {
      desc = 'git: preview hunk',
    })

    command('GitRestore', M.restore, {
      desc = 'git: restore file to last committed version',
    })
    cabbrev('Grt', 'GitRestore')

    command('GitWrite', M.write, {
      desc = 'git: add diff to stage',
    })
    cabbrev('Gw', 'GitWrite')
    cabbrev('Ga', 'GitWrite')

    command('GitBranchCurrent', M.branch_current, {
      desc = 'git: print current branch name',
    })
  end,
}
