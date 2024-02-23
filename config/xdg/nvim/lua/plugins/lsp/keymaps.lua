local utils = require('utils')

local function buffer_format()
  utils.buffers.preserve(function()
    vim.cmd([[normal! gg=G]])
  end)
  vim.cmd.LspFormat()
end

return {
  setup = function(bufnr)
    local function keymap(desc, mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, {
        silent = true,
        buffer = bufnr,
        desc = 'lsp: ' .. desc,
      })
    end

    keymap('hover', 'n', 'K', vim.lsp.buf.hover)
    keymap('signature help', 'n', '<c-k>', vim.lsp.buf.signature_help)
    keymap('format (sync)', 'n', '<leader>f=', buffer_format)

    keymap('rename', 'n', 'grr', vim.lsp.buf.rename)

    keymap('code actions', { 'n', 'v', 'x' }, 'gla', vim.lsp.buf.code_action)
    keymap('declarations', 'n', 'glD', vim.lsp.buf.declaration)

    require('plugins.fuzzyfinder.lsp').setup(vim.lsp, keymap)
  end,
}
