local M = {}

local new_terminal_cmd = {
  cmd = 'new',
  mods = {
    split = 'botright',
    silent = true,
  },
}

local function open_window(termdata)
  local opened_from = {
    win = vim.api.nvim_get_current_win(),
    pos = vim.fn.getcurpos(),
  }
  local cmd = vim.deepcopy(new_terminal_cmd)

  cmd.mods.vertical = termdata.opts.position == 'vertical'
  cmd.mods.horizontal = termdata.opts.position ~= 'vertical'

  if termdata.bufnr ~= nil then
    cmd.cmd = 'split'
  end

  vim.cmd(cmd)

  termdata.winid = vim.api.nvim_get_current_win()

  if termdata.bufnr ~= nil then -- when re-opening a terminal
    vim.api.nvim_win_set_buf(termdata.winid, termdata.bufnr)
  else -- when creating a new terminal
    termdata.bufnr = vim.api.nvim_get_current_buf()
  end

  -- return to original window
  pcall(function()
    vim.api.nvim_set_current_win(opened_from.win)
    vim.fn.setpos('.', opened_from.pos)
  end)

  return termdata
end

---Create a new terminal window
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

---Toggle existing terminal window or create a new one
function M.toggle(termdata, opts)
  if termdata == nil then
    return new_terminal(opts)
  end

  if vim.fn.bufwinid(termdata.bufnr) > 0 then
    vim.api.nvim_win_call(termdata.winid, function()
      vim.cmd.hide()
    end)

    return termdata
  end

  termdata.opts = vim.tbl_deep_extend('force', termdata.opts, opts)

  return open_window(termdata)
end

function M.only(termdata)
  termdata = termdata or new_terminal()

  vim.api.nvim_win_call(termdata.winid, function()
    vim.cmd.only()
  end)

  return termdata
end

---Send the given string to the given terminal
---@param termdata table the given terminal
---@param opts table { string = string, breakline = boolean }
function M.send(termdata, opts)
  termdata = termdata or new_terminal()

  local str = opts.string
  if opts.breakline then
    str = str .. '\n'
  end

  vim.api.nvim_chan_send(termdata.id, str)

  vim.api.nvim_buf_call(termdata.bufnr, function()
    vim.cmd.normal('G')
  end)

  return termdata
end

return {
  ---Execute the given cmd on the given terminal
  --this function is a syntax-sugar to make the remote adapter simpler
  execute = function(cmd)
    return M[cmd.fn](cmd.termdata, cmd.opts)
  end,
}
