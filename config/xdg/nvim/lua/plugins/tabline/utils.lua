local api = vim.api
local buffers = require('my.utils.buffers')
local UNSELECTED = 'Tabline'
local SELECTED = 'TabLineSel'
local FILL = '%#TabLineFill'

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
  return string.format('%%#%s#%s%%*', color, label)
end

local label_for = function(tab)
  local name = get_name(tab)

  local hl = SELECTED
  if not tab.focused then
    hl = UNSELECTED
  end

  local icon, icon_hl = buffers.fileicon_custom_bg(tab.bufnr, hl)

  local components = {
    '',
    string.format('%%%sT', tab.page) .. highlight(string.format('%d', tab.page), hl),
    highlight(icon, icon_hl),
    highlight(name, hl),
    highlight('┃', hl),
  }

  if tab.page == 1 then
    table.remove(components, 1)
    table.insert(components, 1, highlight('┃', hl))
  end

  if tab.focused_tab == (tab.page + 1) then
    table.remove(components, #components)
    table.insert(components, highlight('┃', SELECTED))
  end

  return table.concat(components, ' ')
end

local get_labels = function(focused_tab)
  local tabs = api.nvim_list_tabpages()

  vim.cmd('messages clear')
  return vim.tbl_map(function(tab)
    return label_for({
      id = tab,
      page = api.nvim_tabpage_get_number(tab),
      bufnr = get_bufnr(tab),
      focused = tab == focused_tab,
      focused_tab = focused_tab,
    })
  end, tabs)
end

local get_limit = function(labels, columns)
  local focused_tab = 0
  local limit = 0

  for i, label in ipairs(labels) do
    limit = i
    focused_tab = focused_tab + #label

    if focused_tab >= columns then
      break
    end
  end

  return limit
end

return {
  render = function()
    local focused_tab = api.nvim_get_current_tabpage()
    local current_nr = api.nvim_tabpage_get_number(focused_tab)
    local labels = get_labels(focused_tab)
    local labels_text = table.concat(labels)
    local parsed_text = vim.api.nvim_eval_statusline(labels_text, { use_tabline = true })

    -- Tab labels is not using the whole UI
    if parsed_text.width < vim.o.columns then
      return table.concat({ labels_text, FILL })
    elseif current_nr <= math.floor(#labels / 2) then
      -- When the number of tabs if longer than the UI, some tabs might
      -- get hidden. To ensure the focused_tab, and its surrounds is always
      -- visible, hide only tabs before the focused_tab or farther ahead of the
      -- focused_tab
      local limit = math.min(current_nr + get_limit(labels, vim.o.columns), #labels)

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
        table.concat(labels, '', 1, current_nr - 1),
        '%)',
        table.concat(labels, '', current_nr, #labels),
        FILL,
      })
    end
  end,
}
