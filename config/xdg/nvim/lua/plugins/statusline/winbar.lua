local utils = require('my.utils')
local icons = require('plugins.icons')
local winbar_by_ft = {}
local hl = require('plugins.statusline.utils').highlight
local clickable = require('plugins.statusline.utils').clickable

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

return {
  on_click = function(bufnr, _clicks, button, mods)
    local text = vim.api.nvim_buf_get_name(bufnr)

    if button ~= 'l' then
      text = vim.fn.fnamemodify(text, ':.')
    end

    utils.to_clipboard(text, vim.fn.stridx(mods, 'c') ~= -1)
  end,
  render = function()
    local ft = vim.bo.filetype
    local winid = vim.api.nvim_get_current_win()

    if vim.tbl_contains(vim.tbl_keys(winbar_by_ft), ft) then
      return '%=' .. winbar_by_ft[ft] .. '%='
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local name = get_name(bufnr)

    local winbar_hl = 'Winbar'
    local icon, icon_hl = icons.buffers.fileicon_extend_hl(bufnr, winbar_hl)

    if tonumber(vim.g.actual_curwin) ~= tonumber(winid) then
      winbar_hl = 'WinbarNC'
      icon_hl = 'WinbarNC'
    end

    local clickable_name = clickable(name, 'plugins.winbar.utils')

    return table.concat({
      hl(winbar_hl),
      '%n',
      hl(icon_hl),
      icon,
      hl(winbar_hl),
      clickable_name,
      '%=',
      '%3l:%-3c %3p%% ',
    }, ' ')
  end,
}
