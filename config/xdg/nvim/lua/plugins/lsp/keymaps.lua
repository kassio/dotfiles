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

    keymap('n', 'glD', vim.lsp.buf.declaration, 'declarations')
    keymap('n', 'gd', vim.lsp.buf.definition, 'definitions')

    keymap('n', 'gls', function()
      require('plugins.fuzzyfinder.commands').lsp_document_symbols()
    end, 'document symbols')

    keymap('n', 'gld', function()
      require('plugins.fuzzyfinder.commands').lsp_definitions()
    end, 'definitions')

    keymap('n', 'glr', function()
      require('plugins.fuzzyfinder.commands').lsp_references()
    end, 'references')

    keymap('n', 'gli', function()
      require('plugins.fuzzyfinder.commands').lsp_implementations()
    end, 'implementations')
  end,
}
