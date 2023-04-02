local utils = require('utils')

vim.g.lastplace_ignore = 'gitcommit,gitrebase'
vim.g.lastplace_ignore_buftype = 'quickfix,nofile,help'

local function set_focus(focus)
  local ft = vim.bo.filetype

  if ft == '' or utils.plugin_filetype(ft) then
    return
  end

  vim.opt_local.relativenumber = focus
end

utils.augroup('user:focus', {
  {
    events = {
      'FocusGained',
      'TermClose',
      'TermLeave',
    },
    command = 'checktime',
  },
  {
    events = { 'VimResized' },
    callback = function()
      local curtab = vim.api.nvim_get_current_tabpage()
      vim.cmd.tabdo('wincmd =')
      vim.cmd.tabnext(curtab)
    end,
  },
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
    events = { 'FileType' },
    pattern = {
      'gitcommit',
      'markdown',
    },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  },
  {
    events = { 'RecordingEnter' },
    callback = function()
      vim.g.macromsg = string.format('recording @%s', vim.fn.reg_recording())
    end,
  },
  {
    events = { 'RecordingLeave' },
    callback = function()
      vim.g.macromsg = vim.v.event.regname .. ' recorded'

      utils.after(3000, function()
        vim.g.macromsg = ''
      end)
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
