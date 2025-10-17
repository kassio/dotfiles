local utils = require('utils')

local function keymap_generator(bufnr)
  return function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      silent = true,
      buffer = bufnr,
      desc = 'lsp: ' .. desc,
    })
  end
end

return {
  setup = function(bufnr)
    local keymap = keymap_generator(bufnr)

    keymap('n', '<c-k>', vim.lsp.buf.signature_help, 'signature help')

    keymap('n', 'grr', vim.lsp.buf.rename, 'rename')
    keymap({ 'n', 'v', 'x' }, 'gla', vim.lsp.buf.code_action, 'code actions')

    keymap('n', '<leader>f=', function()
      utils.buffers.preserve(function()
        vim.cmd.LspFormat()
      end)
    end, 'format (sync)')

    require('plugins.lsp.keymaps.lsp').setup(keymap)
  end,
}
