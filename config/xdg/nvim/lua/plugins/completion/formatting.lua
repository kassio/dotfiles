local source_labels = {
  buffer = '',
  bug = '',
  nvim_lsp = '󰒍',
  nvim_lua = '',
  path = '󰇐',
  snippy = '',
  spell = '',
  treesitter = '',
}

setmetatable(source_labels, {
  __index = function()
    return ' '
  end,
})

local function ensure_lengh(content, length)
  if #content > length then
    return vim.fn.strcharpart(content, 0, length - 1) .. '…'
  end

  return content .. string.rep(' ', length - #content)
end

local function icon(entry, item)
  return string.format('│ %s %s', source_labels[entry.source.name], item.kind)
end

local function format(entry, item)
  return vim.tbl_extend('force', item, {
    menu = nil,
    abbr = ensure_lengh(item.abbr or '', 50),
    kind = icon(entry, item),
  })
end

return {
  fields = { 'abbr', 'kind' },
  format = format,
}
