local utils = require('utils')

return {
  setup = function()
    local function lsp_format(bufnr)
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
    end

    vim.api.nvim_create_user_command('LspFormat', function()
      lsp_format(vim.api.nvim_get_current_buf())
    end, {})

    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      group = vim.api.nvim_create_augroup('user:lsp', { clear = false }),
      callback = function(args)
        lsp_format(args.buf)
      end,
    })
  end,
}
