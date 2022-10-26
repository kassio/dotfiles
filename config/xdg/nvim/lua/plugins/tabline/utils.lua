local api = vim.api
local icons = require('plugins.icons')
local utils = require('my.utils.statusline')

local UNSELECTED = 'Tabline'
local SELECTED = 'TabLineSel'
local FILL = '%#TabLineFill'
local SEP = '▍'

local get_bufnr = function(tab)
  local winnr = api.nvim_tabpage_get_win(tab)
  return api.nvim_win_get_buf(winnr)
end

local get_name = function(tab)
  local fullname = api.nvim_buf_get_name(tab.bufnr)

  if #fullname == 0 then
    return '[No name]'
  else
    local name = vim.fn.fnamemodify(fullname, ':t')

    if #name > 50 then
      return '...' .. string.sub(name, #name - 46, -1)
    end

    return name
  end
end

local highlight = function(label, color)
  return string.format('%s%s%%*', utils.highlight(color), label)
end

local label_for = function(tab)
  local name = get_name(tab)

  local hl = SELECTED
  local icon, icon_hl = icons.buffers.fileicon_extend_hl(tab.bufnr, SELECTED)

  if not tab.focused then
    hl = UNSELECTED
    icon_hl = UNSELECTED
  end

  local components = {
    highlight(SEP .. ' ', hl),
    string.format('%%%sT', tab.nr) .. highlight(string.format('%d', tab.nr), hl),
    highlight(' ', hl),
    highlight(icon, icon_hl),
    highlight(' ', hl),
    highlight(name, hl),
    highlight('  ', hl),
  }

  return table.concat(components, '')
end

local get_labels = function(curtab_page, curtab_nr)
  local tabs = api.nvim_list_tabpages()

  vim.cmd('messages clear')
  return vim.tbl_map(function(tab)
    return label_for({
      id = tab,
      nr = api.nvim_tabpage_get_number(tab),
      bufnr = get_bufnr(tab),
      focused = tab == curtab_page,
      curtab_page = curtab_page,
      curtab_nr = curtab_nr,
      count = #tabs,
    })
  end, tabs)
end

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

return {
  render = function()
    local curtab_page = api.nvim_get_current_tabpage()
    local curtab_nr = api.nvim_tabpage_get_number(curtab_page)
    local labels = get_labels(curtab_page, curtab_nr)
    local labels_text = table.concat(labels)
    local parsed_text = vim.api.nvim_eval_statusline(labels_text, { use_tabline = true })

    -- Tab labels is not using the whole UI
    if parsed_text.width < vim.o.columns then
      return table.concat({ labels_text, FILL })
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
        FILL,
      })
    else
      return table.concat({
        '%<(',
        table.concat(labels, '', 1, curtab_nr - 1),
        '%)',
        table.concat(labels, '', curtab_nr, #labels),
        FILL,
      })
    end
  end,
}
