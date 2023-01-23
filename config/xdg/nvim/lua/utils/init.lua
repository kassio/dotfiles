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

--- Get current visual selection text.
---@return string
M.get_visual_selection = function()
  if vim.api.nvim_get_mode().mode == 'n' then
    return vim.fn.expand('<cword>')
  end

  local s_start = vim.api.nvim_buf_get_mark(0, '<')
  local s_end = vim.api.nvim_buf_get_mark(0, '>')
  local start_row = s_start[1] - 1
  local start_col = s_start[2]
  local end_row = s_end[1] - 1
  local end_col = s_end[2] + 1
  local ok, lines = pcall(vim.api.nvim_buf_get_text, 0, start_row, start_col, end_row, end_col, {})

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

M.keycmds = function(tbl)
  for _, data in ipairs(tbl.list) do
    local opts = data.opts or {}
    local cmd_opts = table.slice(opts, { 'range', 'nargs' })

    if opts.bufnr ~= nil then
      vim.api.nvim_buf_create_user_command(
        data.opts.bufnr,
        tbl.prefix .. data.cmd,
        data.fn,
        cmd_opts
      )
    else
      vim.api.nvim_create_user_command(tbl.prefix .. data.cmd, data.fn, cmd_opts)
    end

    vim.keymap.set(data.mode or 'n', data.key, data.fn, table.slice(opts, { 'buffer' }))
  end
end

return M
