return {
  setup = function()
    local diagnostic = vim.diagnostic
    local function keymap(mode, lhr, rhr, desc)
 vim.keymap.set(mode, lhr, rhr, { desc = 'diagnostics: '..desc})
    end

    keymap('n', ']d', function()
      diagnostic.goto_next()
      vim.cmd.normal('zz')
    end, 'previous')

    keymap('n', '[d', function()
      diagnostic.goto_prev()
      vim.cmd.normal('zz')
    end, 'next')

    keymap('n', 'glee', diagnostic.open_float, 'show current')

    keymap('n', 'glea', function()
      vim.cmd('silent! cclose')
      diagnostic.setloclist()
    end, 'show all diagnostics from buffer')

    keymap('n', 'gleA', function()
      vim.cmd('silent! cclose')
      diagnostic.setqflist()
    end, 'show all diagnostics from workspace')
  end,
}
