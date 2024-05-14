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

    keymap('n', 'K', vim.lsp.buf.hover, 'hover')
    keymap('n', '<c-k>', vim.lsp.buf.signature_help, 'signature help')

    keymap('n', 'grr', vim.lsp.buf.rename, 'rename')
    keymap({ 'n', 'v', 'x' }, 'gla', vim.lsp.buf.code_action, 'code actions')

    keymap('n', '<leader>f=', function()
      utils.buffers.preserve(function()
        vim.cmd([[normal! gg=G]])
        vim.cmd.LspFormat()
      end)
    end, 'format (sync)')

    keymap('n', 'gls', function()
      require('telescope.builtin').lsp_document_symbols()
    end, 'document symbols')

    keymap('n', 'glS', function()
      require('telescope.builtin').lsp_dynamic_workspace_symbols()
    end, 'workspace symbols')

    keymap('n', 'glD', vim.lsp.buf.declaration, 'declarations')

    keymap('n', 'gd', vim.lsp.buf.definition, 'definitions')
    keymap('n', 'gld', function()
      require('telescope.builtin').lsp_definitions({ jump_type = 'never' })
    end, 'definitions')

    keymap('n', 'glt', function()
      require('telescope.builtin').lsp_type_definitions({ jump_type = 'never' })
    end, 'definitions')

    keymap('n', 'glr', function()
      require('telescope.builtin').lsp_references({ jump_type = 'never' })
    end, 'references')

    keymap('n', 'gli', function()
      require('telescope.builtin').lsp_implementations({ jump_type = 'never' })
    end, 'implementations')
  end,
}
