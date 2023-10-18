return {
  setup = function(manager)
    local group = vim.api.nvim_create_augroup('user:terminal', { clear = false })

    vim.api.nvim_create_autocmd({ 'TermOpen' }, {
      group = group,
      callback = function(event)
        vim.bo[event.buf].filetype = 'terminal'
      end,
    })

    vim.api.nvim_create_autocmd({ 'TermClose' }, {
      group = group,
      callback = function()
        pcall(function()
          manager.cmd('quit!')
          manager.active = nil
        end)
      end,
    })
  end,
}
