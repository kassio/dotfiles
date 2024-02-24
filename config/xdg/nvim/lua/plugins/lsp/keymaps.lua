local utils = require('utils')

local function buffer_format()
  utils.buffers.preserve(function()
    vim.cmd([[normal! gg=G]])
    vim.cmd.LspFormat()
  end)
end

local function keymapper(bufnr)
  return function(desc, mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {
      silent = true,
      buffer = bufnr,
      desc = 'lsp: ' .. desc,
    })
  end
end

return {
  setup = function(bufnr)
    local keymap = keymapper(bufnr)

    keymap('hover', 'n', 'K', vim.lsp.buf.hover)
    keymap('signature help', 'n', '<c-k>', vim.lsp.buf.signature_help)
    keymap('format (sync)', 'n', '<leader>f=', buffer_format)
    keymap('rename', 'n', 'grr', vim.lsp.buf.rename)
    keymap('code actions', { 'n', 'v', 'x' }, 'gla', vim.lsp.buf.code_action)
    keymap('declarations', 'n', 'glD', vim.lsp.buf.declaration)

    require('plugins.fuzzyfinder.lsp').setup(vim.lsp, keymap)
  end,
}
