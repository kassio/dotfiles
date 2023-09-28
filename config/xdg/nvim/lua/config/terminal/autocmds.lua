return {
  setup = function(manager)
    local group = vim.api.nvim_create_augroup('user:terminal', { clear = false })

    vim.api.nvim_create_autocmd({ 'Filetype' }, {
      pattern = 'Terminal',
      group = group,
      callback = function()
        local opt = vim.opt_local

        opt.bufhidden = 'hide'
        opt.cursorline = false
        opt.number = false
        opt.relativenumber = false
        opt.scrolloff = 0
        opt.spell = false
      end,
    })

    vim.api.nvim_create_autocmd({ 'TermClose' }, {
      group = group,
      callback = function(event)
        vim.api.nvim_buf_delete(event.buf, { force = true })
        manager.active = nil
      end,
    })
  end,
}
