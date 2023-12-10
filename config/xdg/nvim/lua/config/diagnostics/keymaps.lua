local function keymap(mode, lhr, rhr, desc)
  vim.keymap.set(mode, lhr, rhr, { desc = 'diagnostics: ' .. desc })
end

local function goto_next(diagnostic, severity)
  return function()
    diagnostic.goto_next({ severity = severity })
    vim.cmd.normal('zz')
  end
end

local function goto_prev(diagnostic, severity)
  return function()
    diagnostic.goto_prev({ severity = severity })
    vim.cmd.normal('zz')
  end
end

return {
  setup = function()
    local diagnostic = vim.diagnostic

    keymap('n', ']d', goto_next(diagnostic), 'next')
    keymap('n', '[d', goto_prev(diagnostic), 'previous')
    keymap('n', ']h', goto_next(diagnostic, diagnostic.severity.HINT), 'next')
    keymap('n', '[h', goto_prev(diagnostic, diagnostic.severity.HINT), 'previous')
    keymap('n', ']i', goto_next(diagnostic, diagnostic.severity.INFO), 'next')
    keymap('n', '[i', goto_prev(diagnostic, diagnostic.severity.INFO), 'previous')
    keymap('n', ']w', goto_next(diagnostic, diagnostic.severity.WARN), 'next')
    keymap('n', '[w', goto_prev(diagnostic, diagnostic.severity.WARN), 'previous')
    keymap('n', ']e', goto_next(diagnostic, diagnostic.severity.ERROR), 'next')
    keymap('n', '[e', goto_prev(diagnostic, diagnostic.severity.ERROR), 'previous')

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
