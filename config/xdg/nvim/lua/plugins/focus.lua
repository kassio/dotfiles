local utils = require('my.utils')

vim.g.lastplace_ignore = 'gitcommit,gitrebase'
vim.g.lastplace_ignore_buftype = 'quickfix,nofile,help'

local function set_focus(value)
  local ft = vim.bo.filetype

  if ft == '' or utils.plugin_filetype(ft) then
    return
  end

  vim.opt_local.relativenumber = value
end

utils.augroup('user:focus', {
  {
    events = {
      'WinLeave',
      'BufLeave',
      'FocusLost',
    },
    callback = function()
      set_focus(false)
    end,
  },
  {
    events = {
      'WinEnter',
      'BufEnter',
      'FocusGained',
    },
    callback = function()
      set_focus(true)
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
        utils.buffers.trim()
        vim.cmd('silent! wall!')
      end
    end,
  },
})
