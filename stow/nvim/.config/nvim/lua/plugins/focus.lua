vim.g.lastplace_ignore = 'gitcommit,gitrebase'
vim.g.lastplace_ignore_buftype = 'quickfix,nofile,help'

local function set_relative_number(value)
  if vim.my.utils.plugin_filetype(vim.bo.filetype) then
    return
  end

  vim.opt_local.relativenumber = value
end

vim.my.utils.augroup('user:focus', {
  {
    events = {
      'WinLeave',
      'BufLeave',
      'FocusLost',
    },
    callback = function()
      set_relative_number(false)
    end,
  },
  {
    events = {
      'WinEnter',
      'BufEnter',
      'FocusGained',
    },
    callback = function()
      set_relative_number(true)
    end,
  },
  {
    events = {
      'BufEnter',
      'BufLeave',
      'FocusLost',
      'TextChanged',
      'VimLeavePre',
      'VimSuspend',
    },
    callback = function()
      if vim.bo.modifiable then
        vim.my.buffers.trim()
        vim.cmd('silent! wall!')
      end
    end,
  },
})