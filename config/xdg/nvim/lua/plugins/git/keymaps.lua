local function keymap(mode, keys, cb, desc)
  vim.keymap.set(mode, keys, cb, { desc = 'git: ' .. desc })
end

return {
  setup = function(gitsigns)
    keymap('n', ']g', function()
      gitsigns.next_hunk()
      vim.cmd.normal('zz')
    end, 'next hunk')

    keymap('n', '[g', function()
      gitsigns.prev_hunk()
      vim.cmd.normal('zz')
    end, 'previous hunk')

    keymap('n', '<c-g><c-w>', gitsigns.stage_hunk, 'stage hunk (add)')
    keymap('n', '<c-g><c-u>', gitsigns.reset_hunk, 'reset hunk (undo)')
    keymap('n', '<c-g><c-c>', function()
      vim.cmd.Git('restore %')
    end, 'restore file')

    keymap('n', '<c-g><c-d>', gitsigns.preview_hunk, 'preview hunk (diff)')
    keymap('n', '<c-g><c-l>', vim.cmd.GitBlame, 'blame current file')
  end,
}
