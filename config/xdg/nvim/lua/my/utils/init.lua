local M = {}
local api = vim.api
local fn = vim.fn

M.treesitter = require('my.utils.treesitter')
M.buffers = require('my.utils.buffers')
M.reloader = require('my.utils.reloader')
M.snippets = require('my.utils.snippets')
M.highlights = require('my.utils.highlights')

M.get_visual_selection = function()
  local s_start = vim.api.nvim_buf_get_mark(0, '<')
  local s_end = vim.api.nvim_buf_get_mark(0, '>')
  local start_row = s_start[1] - 1
  local start_col = s_start[2]
  local end_row = s_end[1] - 1
  local end_col = s_end[2] + 1
  local ok, lines = pcall(vim.api.nvim_buf_get_text, 0, start_row, start_col, end_row, end_col, {})

  if ok then
    return table.concat(lines, '\n')
  else
    print('Failed to get selection: ' .. lines)
    return ''
  end
end

M.to_clipboard = function(text, use_external_clipboard)
  if use_external_clipboard then
    fn.setreg('*', text)
    print(string.format('"%s" copied to system clipboard', text))
  else
    fn.setreg('"', text)
    print(string.format('"%s" copied to clipboard', text))
  end
end

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

M.fileicon = function(filetype, filename)
  local filetype_extensions = {
    go = 'go',
    ruby = 'rb',
    sh = 'sh',
    bash = 'bash',
    zsh = 'zsh',
  }

  local extension = filetype_extensions[filetype] or fn.fnamemodify(filename, ':e') or filetype

  return require('nvim-web-devicons').get_icon(filename, extension, { default = true })
end

local plugin_filetypes = {
  'NvimTree',
  'TelescopePrompt',
  'TelescopeResults',
  'fzf',
  'help',
  'neoterm',
  'notify',
  'packer',
  'cmp_menu',
  'cmp_docs',
  'FineCmdlinePrompt',
}

M.plugin_filetype = function(ft)
  return vim.tbl_contains(plugin_filetypes, ft or vim.bo.filetype)
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

return M
