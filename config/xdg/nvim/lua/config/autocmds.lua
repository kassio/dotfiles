local utils = require('utils')

vim.g.lastplace_ignore = 'gitcommit,gitrebase'
vim.g.lastplace_ignore_buftype = 'quickfix,nofile,help'

utils.augroup('user:focus', {
  { -- autosave file
    events = {
      'FocusGained',
      'TermClose',
      'TermLeave',
    },
    command = 'checktime',
  },
  { -- keep splits sizes
    events = { 'VimResized' },
    callback = function()
      local curtab = vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())
      vim.cmd.tabdo('wincmd =')
      vim.cmd.tabnext(curtab)
    end,
  },
  { -- used on statusline
    events = { 'RecordingEnter' },
    callback = function()
      vim.g.macromsg = string.format('recording @%s', vim.fn.reg_recording())
    end,
  },
  { -- used on statusline
    events = { 'RecordingLeave' },
    callback = function()
      vim.g.macromsg = vim.v.event.regname .. ' recorded'

      vim.defer_fn(function()
        vim.g.macromsg = ''
      end, 3000)
    end,
  },
  { -- autoformat
    events = 'BufWritePre',
    callback = function()
      if not vim.bo.modifiable or vim.b.skip_autoformat == true then
        return
      end

      vim.lsp.buf.format({ async = false })
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
      if not vim.bo.modifiable then
        return
      end

      utils.buffers.trim()
      vim.cmd('silent! wall!')
    end,
  },
})
