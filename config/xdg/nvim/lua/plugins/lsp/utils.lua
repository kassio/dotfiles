local fuzzy_commands = require('plugins.fuzzyfinder.commands')
local lsp_methods = vim.lsp.protocol.Methods
local formattable_servers = require('plugins.lsp.servers').formattable

local function can_format(client, bufnr)
  return
    vim.bo[bufnr].modifiable
    and client
    and vim.tbl_contains(formattable_servers, client.name)
    and client:supports_method(lsp_methods.textDocument_formatting)
end


local function format_with(client, bufnr)
  require('utils.buffers').preserve(function()
    vim.cmd('messages clear')
    vim.print('>> ' .. client.name)
    vim.print('is a formattable server? ' .. tostring(vim.tbl_contains(formattable_servers, client.name)))
    vim.print('server format? ' .. tostring(client:supports_method(lsp_methods.textDocument_formatting)))
    vim.print('buf is modifiable? ' .. tostring(vim.bo[bufnr].modifiable))
    vim.cmd('messages')

    vim.cmd([[silent! normal! gg=G]])
    if can_format(client, bufnr) then
      vim.lsp.buf.format({ id = client.id, bufnr = 0 })
    end
  end)
end

M = {}

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

function M.format(bufnr)
  bufnr = bufnr or 0

  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    format_with(client, bufnr)
  end
end

return M
