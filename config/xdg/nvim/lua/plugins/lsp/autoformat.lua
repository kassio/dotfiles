local utils = require('utils')

local function lsp_format(client, bufnr, async)
  local filetype = vim.bo[bufnr].filetype
  if
    not vim.bo[bufnr].modifiable
    or filetype == ''
    or utils.plugin_filetype(filetype)
    or vim.b[bufnr].skip_autoformat == true
  then
    return
  end

  vim.lsp.buf.format({
    async = async,
    filter = function(c)
      return c.name == client.name
    end,
  })
end

return {
  setup = function(client, bufnr)
    if vim.b[bufnr].lsp_format_set then
      return
    end

    vim.api.nvim_create_user_command('LspFormat', function()
      lsp_format(client, bufnr, true)
    end, {})

    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      group = vim.api.nvim_create_augroup('user:lsp', { clear = false }),
      buffer = bufnr,
      callback = function()
        lsp_format(client, bufnr, false)
      end,
    })

    vim.b[bufnr].lsp_format_set = true
  end,
}
