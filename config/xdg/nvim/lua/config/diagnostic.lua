local diagnostic = vim.diagnostic

vim.keymap.set('n', ']d', function()
  diagnostic.goto_next()
  vim.cmd.normal('zz')
end, { desc = 'diagnostic: previous hunk' })

vim.keymap.set('n', '[d', function()
  diagnostic.goto_prev()
  vim.cmd.normal('zz')
end, { desc = 'diagnostic: next hunk' })

vim.keymap.set('n', 'glee', diagnostic.open_float, { desc = 'diagnostic: show current diagnostic' })
vim.keymap.set('n', 'glea', function()
  vim.cmd('silent! cclose')
  diagnostic.setloclist()
end, { desc = 'diagnostic: show all diagnostics from buffer' })
vim.keymap.set('n', 'gleA', function()
  vim.cmd('silent! cclose')
  diagnostic.setqflist()
end, { desc = 'diagnostic: show all diagnostics from workspace' })

diagnostic.config({
  virtual_text = {
    severity = diagnostic.severity.ERROR,
    spacing = 8,
  },
  underline = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})
