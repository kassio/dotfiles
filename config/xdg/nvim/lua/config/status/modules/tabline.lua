local api = vim.api
local SEP = ' '

local function get_limit(labels, columns)
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

local function tab_get_bufnr(tab_page)
  local winnr = api.nvim_tabpage_get_win(tab_page)
  return api.nvim_win_get_buf(winnr)
end

local function filename(bufnr)
  local fullname = api.nvim_buf_get_name(bufnr)

  if #fullname == 0 then
    return '[No name]'
  else
    local name = vim.fn.fnamemodify(fullname, ':t')

    if #name >= 77 then
      return '...' .. string.sub(name, #name - 74)
    end

    return name
  end
end

local function tab_label(opts)
  local tabnr = api.nvim_tabpage_get_number(opts.tab_page)
  local components = {
    SEP,
    ' ',
    string.format('%%%sT%s', tabnr, tabnr),
    ' ',
    filename(tab_get_bufnr(opts.tab_page)),
    ' ',
    SEP,
  }

  if opts.first then
    components[1] = '%#Tabline#' .. components[1]
  elseif (opts.curtab_nr + 1) == opts.tab_nr then
    -- tab after the focused one
    components[1] = ''
  end

  if opts.focused then
    components[1] = '%#TablineSel#' .. SEP
    components[#components] = SEP .. '%#Tabline#'
  elseif not opts.last then
    components[#components] = ''
  end

  return table.concat(components, '')
end

local function fix_relative_position(labels, curtab_nr)
  local labels_text = table.concat(labels)
  local parsed_text = vim.api.nvim_eval_statusline(labels_text, { use_tabline = true })

  -- Tab labels is not using the whole UI
  if parsed_text.width < vim.o.columns then
    return labels_text
  elseif curtab_nr <= math.floor(#labels / 2) then
    -- When the number of tabs if longer than the UI, some tabs might
    -- get hidden. To ensure the curtab_nr, and its surrounds is always
    -- visible, hide only tabs before the curtab_nr or farther ahead of the
    -- curtab_nr
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
    local curtab_nr = api.nvim_tabpage_get_number(curtab_page)
    local tab_pages = api.nvim_list_tabpages()
    local tab_nr = 0

    local labels = vim.tbl_map(function(tab_page)
      tab_nr = tab_nr + 1

      return tab_label({
        tab_page = tab_page,
        tab_nr = tab_nr,
        curtab_nr = curtab_nr,
        focused = curtab_nr == tab_nr,
        first = tab_nr == 1,
        last = tab_nr == #tab_pages,
      })
    end, tab_pages)

    return fix_relative_position(labels, curtab_nr) .. '%#TabLineFill#'
  end,
}
