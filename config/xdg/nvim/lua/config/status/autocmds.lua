return {
  setup = function()
    local group = vim.api.nvim_create_augroup('user:statusline', { clear = true })
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

    vim.api.nvim_create_autocmd('CmdlineEnter', {
      group = group,
      desc = 'Do not hide the status line when typing a command',
      callback = function()
        vim.opt.cmdheight = 1
      end,
    })

    vim.api.nvim_create_autocmd('CmdlineLeave', {
      group = group,
      desc = 'Hide cmdline when not typing a command',
      callback = function()
        vim.opt.cmdheight = 0
      end,
    })
  end,
}
