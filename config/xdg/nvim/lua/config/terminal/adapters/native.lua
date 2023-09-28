local M = {}

local function open_window(termdata)
  local opened_from = { win = vim.api.nvim_get_current_win(), pos = vim.fn.getcurpos() }
  local cmd = {
    cmd = 'new',
    mods = {
      split = 'botright',
      silent = true,
      vertical = termdata.opts.position == 'vertical',
      horizontal = termdata.opts.position ~= 'vertical',
    },
  }

  if termdata.bufnr ~= nil then
    cmd.cmd = 'split'
  end

  vim.cmd(cmd)

  termdata.winid = vim.api.nvim_get_current_win()
  if termdata.bufnr ~= nil then
    vim.api.nvim_win_set_buf(termdata.winid, termdata.bufnr)
  else
    termdata.bufnr = vim.api.nvim_get_current_buf()
    vim.bo[termdata.bufnr].filetype = 'terminal'
  end

  pcall(function() -- return to original window
    vim.api.nvim_set_current_win(opened_from.win)
    vim.fn.setpos('.', opened_from.pos)
  end)

  return termdata
end

local function scroll_after(termdata, callback)
  callback()
  vim.api.nvim_buf_call(termdata.bufnr, function()
    vim.cmd.normal('G')
  end)
end

--- Create a new terminal window
local function new_terminal(opts)
  local termdata = {
    opts = vim.tbl_deep_extend('keep', opts or {}, {
      shell = vim.env.SHELL,
      position = 'horizontal',
    }),
  }

  termdata = open_window(termdata)

  vim.api.nvim_win_call(termdata.winid, function()
    termdata.id = vim.fn.termopen(termdata.opts.shell)
  end)

  return termdata
end

--- Toggle existing terminal window or create a new one
function M.toggle(termdata, opts)
  if termdata == nil then
    return new_terminal(opts)
  end

  if vim.fn.bufwinid(termdata.bufnr) > 0 then
    vim.api.nvim_win_hide(termdata.winid)
    return termdata
  end

  termdata.opts = vim.tbl_deep_extend('force', termdata.opts, opts or {})

  return open_window(termdata)
end

function M.only(termdata)
  termdata = termdata or new_terminal()

  vim.api.nvim_win_call(termdata.winid, function()
    vim.cmd.only()
  end)

  return termdata
end

function M.send(termdata, str)
  termdata = termdata or new_terminal()

  scroll_after(termdata, function()
    vim.api.nvim_chan_send(termdata.id, str .. '\n')
  end)

  return termdata
end

function M.keycode(termdata, str)
  termdata = termdata or new_terminal()

  scroll_after(termdata, function()
    vim.api.nvim_chan_send(termdata.id, vim.keycode(str))
  end)

  return termdata
end

return M
