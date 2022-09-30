local utils = require('my.utils')
local icons = require('plugins.icons')
local winbar_by_ft = {}

for ft in ipairs(utils.plugin_filetypes) do
  winbar_by_ft[ft] = ''
end

winbar_by_ft[''] = '…'
winbar_by_ft.NvimTree = 'explorer'
winbar_by_ft.neoterm = 'neoterm'
winbar_by_ft.help = 'help'
winbar_by_ft.packer = 'plugins'

local get_name = function(bufnr)
  local fullname = vim.api.nvim_buf_get_name(bufnr)

  if #fullname == 0 then
    return '[No name]'
  else
    local name = vim.fn.fnamemodify(fullname, ':.')

    if #name > 70 then
      local parts = vim.split(name, '/')
      return '.../' .. table.concat(parts, '/', 2, #parts)
    end

    return name
  end
end

local highlight = function(label, color)
  return string.format('%%#%s#%s%%*', color, label)
end

return {
  render = function()
    local ft = vim.bo.filetype
    local winid = vim.api.nvim_get_current_win()

    if vim.tbl_contains(vim.tbl_keys(winbar_by_ft), ft) then
      return '%=' .. winbar_by_ft[ft] .. '%='
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local name = get_name(bufnr)

    local hl = 'Winbar'
    local icon, icon_hl = icons.buffers.fileicon_extend_hl(bufnr, hl)

    if tonumber(vim.g.actual_curwin) ~= tonumber(winid) then
      hl = 'WinbarNC'
      icon_hl = 'WinbarNC'
    end

    return table.concat({
      highlight('%=', hl),
      highlight(icon, icon_hl),
      highlight(name, hl),
      highlight('%n', hl),
      highlight('%=', hl),
    }, ' ')
  end,
}
