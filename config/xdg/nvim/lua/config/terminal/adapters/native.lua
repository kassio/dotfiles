local M = {}

local default_terminal_cmd = {
  cmd = 'new',
  mods = {
    split = 'botright',
    silent = true,
  },
}

local function get_size(tabpage, termdata)
  local win = termdata.tabmap[tabpage]

  if termdata.opts.position == 'vertical' then
    return vim.api.nvim_win_get_width(win)
  else
    return vim.api.nvim_win_get_height(win)
  end
end

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

  if termdata.opts.size ~= nil then
    cmd.range = { termdata.opts.size }
  end

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
---If a terminal exists but it's not open on the current tab,
---opens the terminal in current tab
function M.toggle(termdata, opts)
  termdata = termdata or {}
  local tabpage = vim.api.nvim_get_current_tabpage()

  -- active & hidden terminal
  if vim.tbl_get(termdata, 'tabmap', tabpage) == nil then
    return open_terminal_window(vim.tbl_deep_extend('force', termdata, { opts = opts }))
  else
    -- save terminal size to reopen in the same size
    termdata.opts.size = get_size(tabpage, termdata)
    local ok, _ = pcall(M.nvim_cmd, termdata, { string = 'hide' })
    termdata.tabmap[tabpage] = nil

    -- hide terminal
    if ok then
      return termdata
    end

    -- terminal doesn't exist, retry to create a new one
    termdata.bufnr = nil
    return M.toggle(termdata)
  end
end

function M.nvim_cmd(termdata, opts)
  termdata = termdata or open_terminal_window(opts)

  if termdata.bufnr == nil then
    return termdata
  end

  pcall(vim.api.nvim_buf_call, termdata.bufnr, function()
    vim.cmd(opts.string)
  end)

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

  M.nvim_cmd(termdata, { string = 'normal G' })

  return termdata
end

local adapter = { name = 'native' }

---Execute the given cmd on the given terminal
--this function is a syntax-sugar to make the remote adapter simpler
function adapter.execute(cmd)
  local fn = M[cmd.fn]
  if fn == nil then
    vim.print(string.format('[%s] %s not supported', adapter.name, cmd.fn))
    return
  end

  return fn(cmd.termdata, cmd.opts)
end

return adapter
