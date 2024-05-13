local utils = require('utils')

return {
  setup = function()
    local aug = vim.api.nvim_create_augroup('user:lsp', { clear = false })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
      group = aug,
      callback = function(args)
        local clients = vim.lsp.get_clients({ bufnr = args.buf })

        if utils.plugin_filetype() then
          vim.lsp.stop_client(clients)
        end
      end,
    })

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
              vim.lsp.buf.format({ async = false })
            end
          end,
        })
      end,
    })
  end,
}
