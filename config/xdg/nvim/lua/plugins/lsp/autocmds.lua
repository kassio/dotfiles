return {
  setup = function()
    local autogroup = vim.api.nvim_create_augroup('user:lsp', { clear = false })

    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      group = autogroup,
      callback = function(opts)
        if vim.b[opts.buf].autoformat ~= false then
          vim.cmd('silent! LspFormat')
        end
      end,
    })

    vim.api.nvim_create_autocmd({ 'LspAttach' }, {
      group = autogroup,
      callback = function(opts)
        require('plugins.lsp.keymaps').setup(opts.buf)
      end,
    })
  end,
}
