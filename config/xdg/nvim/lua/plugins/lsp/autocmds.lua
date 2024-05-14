local utils = require('utils')

return {
  setup = function()
    local aug = vim.api.nvim_create_augroup('user:lsp', { clear = false })

    vim.api.nvim_create_autocmd({ 'LspAttach' }, {
      group = aug,
      callback = function(args)
        require('plugins.lsp.commands').setup()
        require('plugins.lsp.keymaps').setup(args.buf)

        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
          group = vim.api.nvim_create_augroup('user:lsp', { clear = false }),
          buffer = args.buf,
          callback = function()
            if vim.b[args.buf].autoformat ~= false then
              vim.cmd.LspFormat()
            end
          end,
        })
      end,
    })
  end,
}
