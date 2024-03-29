vim.keymap.set('n', 'gleA', function()
  require('telescope.builtin').diagnostics({
    layout_strategy = 'vertical',
  })
end, { desc = 'workspace diagnostics' })

vim.keymap.set('n', 'glea', function()
  require('telescope.builtin').diagnostics({
    layout_strategy = 'vertical',
    bufnr = 0,
  })
end, { desc = 'buffer diagnostics' })
