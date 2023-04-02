local M = {}
local api = vim.api
local fn = vim.fn

M.buffers = require('utils.buffers')
M.snippets = require('utils.snippets')
M.highlights = require('utils.highlights')

M.plugin_filetypes = {
  'FineCmdlinePrompt',
  'NvimTree',
  'Outline',
  'TelescopePrompt',
  'TelescopeResults',
  'cmp_docs',
  'cmp_menu',
  'fzf',
  'help',
  'neoterm',
  'notify',
  'packer',
}

local ensure_positive = function(value)
  if value < 0 then
    return 0
  end

  return value
end

--- Get current visual selection text.
---@return string
M.get_visual_selection = function()
  local _, start_row, start_col, _ = table.unpack(fn.getpos("'<"))
  local _, end_row, end_col, _ = table.unpack(fn.getpos("'>"))

  local selection = {
    start_row = ensure_positive(start_row - 1),
    start_col = ensure_positive(start_col - 1),
    end_row = ensure_positive(end_row - 1),
    end_col = end_col,
  }

  local ok, lines = pcall(
    api.nvim_buf_get_text,
    0,
    selection.start_row,
    selection.start_col,
    selection.end_row,
    selection.end_col,
    {}
  )

  if not ok then
    print('Failed to get selection: ' .. lines)
    return vim.fn.expand('<cword>')
  end

  return table.concat(lines, '\n')
end

--- Copy given text to clipboard.
---@param text string
---@param system_clipboard boolean
---@return nil
M.to_clipboard = function(text, system_clipboard)
  local reg = '"'
  local fmt = string.trim([[
"%s"
copied to %s
]])
  local msg = 'a register'

  if system_clipboard then
    reg = '*'
    msg = 'the system clipboard'
  end

  fn.setreg(reg, text)
  vim.notify(string.format(fmt, text, msg), vim.log.levels.INFO)
end

--- Creates an autocommand group.
---@param name string
---@param autocmds any[]
M.augroup = function(name, autocmds)
  local group = api.nvim_create_augroup(name, { clear = true })
  for _, opts in ipairs(autocmds) do
    local events = table.removekey(opts, 'events')
    opts['group'] = group
    api.nvim_create_autocmd(events, opts)
  end
end

M.cabbrev = function(lhs, rhs)
  vim.cmd(string.format('cabbrev %s %s', lhs, rhs))
end

M.plugin_filetype = function(ft)
  return vim.tbl_contains(M.plugin_filetypes, ft or vim.bo.filetype)
end

local valid_flag = function(flag)
  return vim.tbl_contains({ 'p', 'h', 't', 'r', 'e', '.', '~' }, flag)
end

local ensure_valid_file_flag = function(flag)
  flag = string.gsub(string.lower(tostring(flag)), '[:%%]', '')
  if valid_flag(flag) then
    return '%:' .. flag
  else
    return '%:.'
  end
end

M.copy_filename = function(cmd)
  local flag = ensure_valid_file_flag(cmd.args)
  local filename = fn.expand(flag)

  M.to_clipboard(filename, cmd.bang)
end

M.after = function(ms, callback)
  local timer = vim.loop.new_timer()
  timer:start(ms, 0, callback)
end

return M
