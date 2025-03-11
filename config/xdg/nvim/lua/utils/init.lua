local M = {}
local api = vim.api
local fn = vim.fn

M.plugin_filetypes = {
  'FineCmdlinePrompt',
  'Outline',
  'TelescopePrompt',
  'TelescopeResults',
  'cmp_docs',
  'cmp_menu',
  'fzf',
  'help',
  'neo-tree',
  'notify',
  'packer',
  'terminal',
}

function M.is_present(value)
  return not M.is_blank(value)
end

function M.is_blank(value)
  if type(value) == 'nil' then
    return true
  elseif type(value) == 'number' and value == 0 then
    return true
  elseif type(value) == 'string' and value == '' then
    return true
  elseif type(value) == 'boolean' and value == false then
    return true
  elseif type(value) == 'table' and value == {} then
    return true
  end

  return false
end

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

function M.on_each_non_plugin_window(callback)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local bufnr = vim.api.nvim_win_get_buf(win)

    if not M.plugin_filetype(vim.bo[bufnr].filetype) then
      vim.api.nvim_win_call(win, callback)
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
  local n = { title = base, sep = (sep or ':') }

  setmetatable(n, {
    __index = function(tbl, key)
      if not vim.tbl_contains(vim.tbl_keys(vim.log.levels), string.upper(key)) then
        vim.print(key .. ': log level not found')
        return
      end

      return function(msg, title)
        if vim.tbl_isempty(vim.api.nvim_list_uis()) then
          local fullmsg = table.concat(M.table.compact_list({ title, msg }), tbl.sep)
          vim.print(string.format('[%s][%s] %s', string.upper(key), fullmsg))
        else
          local fulltitle = table.concat(M.table.compact_list({ tbl.title, title }), sep)
          vim.notify(msg, key, { title = fulltitle })
        end
      end
    end,
  })

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

setmetatable(M, {
  __index = function(utils, key)
    local ok, module = pcall(require, 'utils.' .. key)

    if ok then
      utils[key] = module
      return module
    end

    return nil
  end,
})

return M
