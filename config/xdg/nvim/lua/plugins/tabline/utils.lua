local api = vim.api
local buffers = require('my.utils.buffers')

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
  local icon, hl_icon = buffers.fileicon(tab.bufnr)
  local hl = 'TabLineSel'

  if not tab.focused then
    hl = 'TabLine'
    hl_icon = 'TabLine'
  end

  local sep = highlight('┃', hl)

  local components = {
    sep,
    string.format('%%%sT', tab.page) .. highlight(string.format('%d', tab.page), hl),
    highlight(icon, hl_icon),
    highlight(name, hl),
  }

  if tab.id == tab.count then
    table.insert(components, sep)
  else
    table.insert(components, '')
  end

  return table.concat(components, ' ')
end

local get_labels = function(focused_tab)
  local tabs = api.nvim_list_tabpages()

  return vim.tbl_map(function(tab)
    return label_for({
      id = tab,
      page = api.nvim_tabpage_get_number(tab),
      bufnr = get_bufnr(tab),
      focused = tab == focused_tab,
      count = #tabs,
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
      return table.concat({ '%#TabLine#', labels_text, '%#TabLineFill' })
    elseif current_nr <= math.floor(#labels / 2) then
      -- When the number of tabs if longer than the UI, some tabs might
      -- get hidden. To ensure the focused_tab, and its surrounds is always
      -- visible, hide only tabs before the focused_tab or farther ahead of the
      -- focused_tab
      local limit = math.min(current_nr + get_limit(labels, vim.o.columns), #labels)

      return table.concat({
        '%#TabLine#',
        table.concat(labels, '', 1, limit),
        '%<(',
        table.concat(labels, '', limit, #labels),
        '%)',
        '%#TabLineFill',
      })
    else
      return table.concat({
        '%#TabLine#',
        '%<(',
        table.concat(labels, '', 1, current_nr - 1),
        '%)',
        table.concat(labels, '', current_nr, #labels),
        '%#TabLineFill',
      })
    end
  end,
}
