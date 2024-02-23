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
        require('plugins.lsp.commands').setup(args.buf)
        require('plugins.lsp.keymaps').setup(args.buf)

        local client = vim.lsp.get_client_by_id(args.data.client_id) or {}
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(args.buf, vim.b[args.buf]['inlay_enabled'] or false)
        end

        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
          group = vim.api.nvim_create_augroup('user:lsp', { clear = false }),
          buffer = args.buf,
          callback = function()
            vim.cmd.LspFormat()
          end,
        })
      end,
    })
  end,
}
