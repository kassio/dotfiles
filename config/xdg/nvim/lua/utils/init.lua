local M = {}
local api = vim.api
local fn = vim.fn

M.buffers = require('utils.buffers')
M.snippets = require('utils.snippets')
M.highlights = require('utils.highlights')
M.symbols = require('utils.symbols')
M.string = require('utils.string')
M.table = require('utils.table')

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
  'terminal',
  'notify',
  'packer',
}

--- Copy given text to clipboard.
---@param text string
---@param system_clipboard boolean
---@return nil
function M.to_clipboard(text, system_clipboard)
  local reg = '"'
  local fmt = M.string.trim([[
"%s"
copied to %s
]])
  local msg = 'a register'

  if system_clipboard then
    reg = '*'
    msg = 'the system clipboard'
  end

  fn.setreg(reg, text)
  vim.notify(string.format(fmt, text, msg))
end

--- Creates an autocommand group.
---@param name string
---@param autocmds any[]
function M.augroup(name, autocmds)
  local group = api.nvim_create_augroup(name, { clear = true })
  for _, opts in ipairs(autocmds) do
    local events = M.table.removekey(opts, 'events')
    opts['group'] = group
    api.nvim_create_autocmd(events, opts)
  end
end

function M.plugin_filetype(ft)
  return vim.tbl_contains(M.plugin_filetypes, ft or vim.bo.filetype)
end

function M.on_each_non_plugin_buffer(callback)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if not M.plugin_filetype(vim.bo[bufnr].filetype) then
      vim.api.nvim_buf_call(bufnr, callback)
    end
  end
end

local function valid_flag(flag)
  return vim.tbl_contains({ 'p', 'h', 't', 'r', 'e', '.', '~' }, flag)
end

local function ensure_valid_file_flag(flag)
  flag = string.gsub(string.lower(tostring(flag)), '[:%%]', '')
  if valid_flag(flag) then
    return '%:' .. flag
  else
    return '%:.'
  end
end

function M.copy_filename(cmd)
  local flag = ensure_valid_file_flag(cmd.args)
  local filename = fn.expand(flag)

  M.to_clipboard(filename, cmd.bang)
end

function M.logger(base, sep)
  sep = sep or ': '
  local n = { title = base }

  local notifier = vim.notify
  if vim.tbl_isempty(vim.api.nvim_list_uis()) then
    notifier = function(msg, level, opts)
      vim.print(
        string.format('[%s][%s] %s', M.table.key_for(vim.log.levels, level), opts.title, msg)
      )
    end
  end

  for name, level in pairs(vim.log.levels) do
    n[string.lower(name)] = function(msg, title)
      local full_title = table.concat(M.table.compact_list({ n.title, title }), sep)
      notifier(msg, level, { title = full_title })
    end
  end

  return n
end

--- Returns <cword> or selection
---@return string|string[]
function M.cword()
  if vim.fn.mode() == 'v' then
    local former_value = vim.fn.getreg('v')
    vim.cmd([[noautocmd silent normal "vy]])

    local selection = vim.fn.getreg('v')
    vim.fn.setreg('v', former_value)

    return selection
  else
    return vim.fn.expand('<cword>')
  end
end

return M
