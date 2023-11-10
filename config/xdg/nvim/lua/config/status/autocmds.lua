return {
  setup = function()
    local group = vim.api.nvim_create_augroup('user:statusline', { clear = false })
    vim.api.nvim_create_autocmd({ 'RecordingEnter' }, {
      group = group,
      callback = function()
        vim.g.macromsg = string.format('recording @%s', vim.fn.reg_recording())
      end,
    })

    vim.api.nvim_create_autocmd({ 'RecordingLeave' }, {
      group = group,
      callback = function()
        vim.g.macromsg = vim.v.event.regname .. ' recorded'

        vim.defer_fn(function()
          vim.g.macromsg = ''
        end, 3000)
      end,
    })

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = { 'Tick' },
      group = group,
      callback = vim.cmd.redrawstatus,
    })
  end,
}
