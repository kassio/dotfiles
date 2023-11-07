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

      local efm = vim.lsp.get_clients({ name = 'efm' })

      if not vim.tbl_isempty(efm) then
        vim.lsp.buf.format({ name = 'efm' })
      else
        for _, client in ipairs(vim.lsp.get_clients()) do
          vim.lsp.buf.format({ name = client.name })
        end
      end
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
