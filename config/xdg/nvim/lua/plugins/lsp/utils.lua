local fuzzy_commands = require('plugins.fuzzyfinder.commands')
M = {}

function M.format(bufnr)
  bufnr = bufnr or 0

  require('utils.buffers').preserve(function()
    vim.cmd([[silent! normal! gg=G]])

    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      if vim.bo[bufnr].modifiable and
        vim.b[bufnr].autoformat ~= false and
        client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then

        vim.lsp.buf.format({ bufnr = 0 })
      end
    end
  end)
end

function M.document_symbols()
  fuzzy_commands.lsp_document_symbols()
end

function M.definitions()
  fuzzy_commands.lsp_definitions()
end

function M.references()
  fuzzy_commands.lsp_references()
end

function M.implementations()
  fuzzy_commands.lsp_implementations()
end

return M
