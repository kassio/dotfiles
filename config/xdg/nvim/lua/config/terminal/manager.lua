local Handler = require('config.terminal.handler')
local Manager = {
  active = nil,
  server = {
    addr = vim.fs.joinpath(vim.fn.stdpath('cache'), 'terminal_server.pipe'),
  },
}

local function open_window(termdata)
  termdata.window = termdata.window or {}

  local opened_from = { win = vim.api.nvim_get_current_win(), pos = vim.fn.getcurpos() }
  local cmd = { cmd = 'new', mods = { silent = true } }

  if termdata.window.bufnr ~= nil then
    cmd.cmd = 'split'
  end

  if termdata.opts.split ~= nil then
    cmd.mods.split = termdata.opts.split
  end

  if termdata.opts.position == 'horizontal' then
    cmd.mods.horizontal = true
  elseif termdata.opts.position == 'vertical' then
    cmd.mods.vertical = true
  end

  vim.cmd(cmd)

  termdata.window.win = vim.api.nvim_get_current_win()
  if termdata.window.bufnr ~= nil then
    vim.api.nvim_win_set_buf(termdata.window.win, termdata.window.bufnr)
  else
    termdata.window.bufnr = vim.api.nvim_get_current_buf()
    vim.bo[termdata.window.bufnr].filetype = 'terminal'
  end

  pcall(function() -- return to original window
    vim.api.nvim_set_current_win(opened_from.win)
    vim.fn.setpos('.', opened_from.pos)
  end)

  return termdata
end

--- Toggle existing terminal window or create a new one
function Manager.toggle(opts)
  local termdata = Manager.active

  if termdata == nil then
    Manager.new(opts)
  elseif vim.fn.bufwinid(termdata.window.bufnr) > 0 then
    vim.api.nvim_win_hide(termdata.window.win)
  else
    termdata.opts = vim.tbl_deep_extend('force', termdata.opts, opts or {})
    Manager.active = open_window(termdata)
  end
end

--- Create a new terminal window
function Manager.new(opts)
  local termdata = {}
  termdata.opts = vim.tbl_deep_extend('keep', opts or {}, {
    after_open = nil, -- function
    shell = vim.env.SHELL, -- string
    position = 'horizontal', -- string
    split = 'botright', -- string
    window = {
      bufnr = nil, -- number
      id = nil, -- number
    },
  })

  termdata = open_window(termdata, true)

  vim.api.nvim_win_call(termdata.window.win, function()
    termdata.id = vim.fn.termopen(termdata.opts.shell)
  end)

  if termdata.opts.after_open ~= nil then
    termdata.opts.after_open(termdata)
  end

  Manager.active = termdata
end

--- Execute given function on exiting terminal, terminal_server or create a new one
function Manager.with_terminal(fn, args, opts)
  if
    Manager.active ~= nil -- this neovim have a managed terminal
    or vim.g.terminal_server == true -- this is the terminal server
    or vim.fn.filereadable(Manager.server.addr) == 0 -- there's no terminal server running
  then
    if Manager.active == nil then
      Manager.new(opts)
    end

    Handler[fn](Manager.active, args)
  else
    vim.system({
      'nvim',
      '--server',
      Manager.server.addr,
      '--remote-send',
      string.format(
        [[<C-\><C-N>:lua require("config.terminal.manager").with_terminal('%s', '%s')<cr>]],
        fn or '',
        args or ''
      ),
    })
  end
end

function Manager.send(str, opts)
  Manager.with_terminal('send', str, opts)
end

function Manager.keycode(str, opts)
  Manager.with_terminal('keycode', str, opts)
end

return Manager
