local hl = require('my.utils').highlights
local theme = require('plugins.highlight.theme')
local hbar = require('plugins.hbar.utils')
local api = vim.api

hl.def('TabLineFill', {
  background = theme.colors.surface1,
})

hl.def('TabLine', {
  foreground = theme.colors.surface2,
  background = theme.colors.surface0,
})

hl.def('TabLineSel', {
  foreground = theme.colors.blue,
  background = theme.colors.base,
  bold = true,
})

local get_limit = function(labels, columns)
  local curtab_page = 0
  local limit = 0

  for i, label in ipairs(labels) do
    limit = i
    curtab_page = curtab_page + #label

    if curtab_page >= columns then
      break
    end
  end

  return limit
end

local tab_get_bufnr = function(tab)
  local winnr = api.nvim_tabpage_get_win(tab)
  return api.nvim_win_get_buf(winnr)
end

local tab_label = function(tab, focused)
  local tabnr = api.nvim_tabpage_get_number(tab)
  local label = string.format(
    '%s ',
    table.concat({
      '▍',
      string.format('%%%sT%s', tabnr, tabnr),
      hbar.render_component('filename', tab_get_bufnr(tab), { fnamemodifier = ':t' }),
    }, ' ')
  )

  if focused then
    return string.format('%%#TabLineSel#%s', label)
  end

  return string.format('%%#TabLine#%s', label)
end

local tab_labels = function(curtab_page)
  return vim.tbl_map(function(tab)
    return tab_label(tab, tab == curtab_page)
  end, api.nvim_list_tabpages())
end

local fix_position = function(labels, curtab_page)
  local curtab_nr = api.nvim_tabpage_get_number(curtab_page)
  local labels_text = table.concat(labels)
  local parsed_text = vim.api.nvim_eval_statusline(labels_text, { use_tabline = true })

  -- Tab labels is not using the whole UI
  if parsed_text.width < vim.o.columns then
    return labels_text
  elseif curtab_nr <= math.floor(#labels / 2) then
    -- When the number of tabs if longer than the UI, some tabs might
    -- get hidden. To ensure the curtab_page, and its surrounds is always
    -- visible, hide only tabs before the curtab_page or farther ahead of the
    -- curtab_page
    local limit = math.min(curtab_nr + get_limit(labels, vim.o.columns), #labels)

    return table.concat({
      table.concat(labels, '', 1, limit),
      '%<(',
      table.concat(labels, '', limit, #labels),
      '%)',
    })
  else
    return table.concat({
      '%<(',
      table.concat(labels, '', 1, curtab_nr - 1),
      '%)',
      table.concat(labels, '', curtab_nr, #labels),
    })
  end
end

return {
  render = function()
    local curtab_page = api.nvim_get_current_tabpage()
    local labels = tab_labels(curtab_page)

    return fix_position(labels, curtab_page) .. '%#TabLineFill'
  end,
}
