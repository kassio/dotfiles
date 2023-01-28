local diagnostic = vim.diagnostic

vim.keymap.set('n', '[d', diagnostic.goto_prev)
vim.keymap.set('n', ']d', diagnostic.goto_next)
vim.keymap.set('n', 'glee', diagnostic.open_float)
vim.keymap.set('n', 'glea', function()
  vim.cmd('silent! cclose')
  diagnostic.setloclist()
end)
vim.keymap.set('n', 'gleA', function()
  vim.cmd('silent! cclose')
  diagnostic.setqflist()
end)

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
