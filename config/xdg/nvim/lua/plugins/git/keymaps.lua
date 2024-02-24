local function keymap(desc, mode, keys, cb)
  vim.keymap.set(mode, keys, cb, { desc = 'git: ' .. desc })
end

return {
  setup = function(gitsigns)
    keymap('next hunk', 'n', ']g', function()
      gitsigns.next_hunk()
      vim.cmd.normal('zz')
    end)

    keymap('previous hunk', 'n', '[g', function()
      gitsigns.prev_hunk()
      vim.cmd.normal('zz')
    end)

    keymap('stage hunk (add)', 'n', '<c-g><c-a>', gitsigns.stage_hunk)

    keymap('preview hunk (diff)', 'n', '<c-g><c-d>', gitsigns.preview_hunk)

    keymap('reset hunk (undo)', 'n', '<c-g><c-u>', gitsigns.reset_hunk)

    keymap('blame current line', 'n', '<c-g><c-l>', function()
      gitsigns.blame_line({ full = true, ignore_whitespace = true })
    end)
  end,
}
