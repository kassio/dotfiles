local utils = require('utils')

local function buffer_format()
  utils.buffers.preserve(function()
    vim.cmd([[normal! gg=G]])
    vim.cmd.LspFormat()
  end)
end

local function keymapper(bufnr)
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
    local keymap = keymapper(bufnr)

    keymap('n', 'K', vim.lsp.buf.hover, 'hover')
    keymap('n', '<c-k>', vim.lsp.buf.signature_help, 'signature help')
    keymap('n', '<leader>f=', buffer_format, 'format (sync)')
    keymap('n', 'grr', vim.lsp.buf.rename, 'rename')
    keymap({ 'n', 'v', 'x' }, 'gla', vim.lsp.buf.code_action, 'code actions')
    keymap('n', 'glD', vim.lsp.buf.declaration, 'declarations')

    keymap('n', 'gls', require('telescope.builtin').lsp_document_symbols, 'document symbols')
    keymap(
      'n',
      'glS',
      require('telescope.builtin').lsp_dynamic_workspace_symbols,
      'workspace symbols'
    )

    keymap('n', 'gd', vim.lsp.buf.definition, 'definitions')

    keymap('n', 'glt', function()
      require('telescope.builtin').lsp_type_definitions({ jump_type = 'never' })
    end, 'definitions')

    keymap('n', 'gld', function()
      require('telescope.builtin').lsp_definitions({ jump_type = 'never' })
    end, 'definitions')

    keymap('n', 'glr', function()
      require('telescope.builtin').lsp_references({ jump_type = 'never' })
    end, 'references')

    keymap('n', 'gli', function()
      require('telescope.builtin').lsp_implementations({ jump_type = 'never' })
    end, 'implementations')
  end,
}
