local M = {}

local default_terminal_cmd = {
  cmd = 'new',
  mods = {
    split = 'botright',
    silent = true,
  },
}

local function open_terminal_window(termdata)
  termdata = vim.tbl_deep_extend('keep', termdata or {}, {
    opts = {
      shell = vim.env.SHELL,
      position = 'horizontal',
    },
  })

  local opened_from = {
    win = vim.api.nvim_get_current_win(),
    pos = vim.fn.getcurpos(),
  }
  local cmd = vim.tbl_deep_extend('force', default_terminal_cmd, {
    mods = {
      vertical = termdata.opts.position == 'vertical',
      horizontal = termdata.opts.position ~= 'vertical',
    },
  })

  if termdata.bufnr ~= nil then
    cmd.cmd = 'split'
  end

  vim.cmd(cmd)

  local winid = vim.api.nvim_get_current_win()
  termdata.tabmap = vim.tbl_get(termdata, 'tabmap') or {}
  termdata.tabmap[vim.api.nvim_get_current_tabpage()] = winid

  if termdata.bufnr ~= nil then -- when re-opening a terminal
    vim.api.nvim_win_set_buf(winid, termdata.bufnr)
  else -- when creating a new terminal
    termdata.id = vim.fn.termopen(termdata.opts.shell)
    termdata.bufnr = vim.api.nvim_get_current_buf()
  end

  -- return to original window
  pcall(function()
    vim.api.nvim_set_current_win(opened_from.win)
    vim.fn.setpos('.', opened_from.pos)
  end)

  return termdata
end

---Toggle existing terminal window or create a new one
function M.toggle(termdata, opts)
  termdata = termdata or {}
  local tabpage = vim.api.nvim_get_current_tabpage()

  if vim.tbl_get(termdata, 'tabmap', tabpage) == nil then -- active & hidden terminal
    return open_terminal_window(vim.tbl_deep_extend('force', termdata, { opts = opts }))
  else
    M.cmd(termdata, { string = 'hide' })
    termdata.tabmap[tabpage] = nil

    return termdata
  end
end

function M.cmd(termdata, opts)
  termdata = termdata or open_terminal_window(opts)

  for _, winid in pairs(termdata.tabmap) do
    vim.api.nvim_win_call(winid, function()
      vim.cmd(opts.string)
    end)
  end

  return termdata
end

---Send the given string to the given terminal
---@param termdata table the given terminal
---@param opts table { string = string, breakline = boolean }
function M.send(termdata, opts)
  termdata = termdata or open_terminal_window(opts)

  local str = opts.string
  if opts.breakline then
    str = str .. '\n'
  end

  vim.api.nvim_chan_send(termdata.id, str)

  M.cmd(termdata, { string = 'normal G' })

  return termdata
end

return {
  ---Execute the given cmd on the given terminal
  --this function is a syntax-sugar to make the remote adapter simpler
  execute = function(cmd)
    return M[cmd.fn](cmd.termdata, cmd.opts)
  end,
}
