local utils = require('utils')

return {
  setup = function(bufnr)
    if vim.tbl_get(vim.b, bufnr, 'lsp_format_set') then
      return
    end

    vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', function()
      local filetype = vim.bo[bufnr].filetype
      if
        not vim.bo[bufnr].modifiable
        or filetype == ''
        or utils.plugin_filetype(filetype)
        or vim.b[bufnr].skip_autoformat == true
      then
        return
      end

      vim.lsp.buf.format({ async = false })
    end, {})

    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      group = vim.api.nvim_create_augroup('user:lsp', { clear = false }),
      buffer = bufnr,
      callback = function()
        vim.cmd.LspFormat()
      end,
    })

    vim.b[bufnr]['lsp_format_set'] = true
  end,
}
