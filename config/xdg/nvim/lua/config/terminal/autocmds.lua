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
      callback = function(event)
        if event.buf == vim.tbl_get(manager, 'active', 'bufnr') then
          manager.active = nil
        end
        pcall(vim.cmd.bwipe, event.buf)
      end,
    })
  end,
}
