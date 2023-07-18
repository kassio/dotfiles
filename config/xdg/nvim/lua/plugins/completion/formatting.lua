local source_labels = {
  buffer = '',
  bug = '',
  nvim_lsp = '',
  nvim_lua = '',
  path = 'פּ',
  snippy = '',
  spell = '暈',
  treesitter = '',
}

local kind_labels = {
  Text = '',
  Method = '',
  Function = '󰊕',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '󰠱',
  Interface = '',
  Module = '󰏓',
  Property = '',
  Unit = '',
  Enum = '',
  EnumMember = '',
  Keyword = '󰌋',
  Snippet = '󰲋',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  Constant = '󰏿',
  Struct = '󰠱',
  Event = '',
  Operator = '',
  TypeParameter = '󰘦',
}

local function ensure_lengh(content, length)
  if #content > length then
    return vim.fn.strcharpart(content, 0, length - 1) .. '…'
  end

  return content .. string.rep(' ', length - #content)
end

local function icon(item, entry)
  local label = kind_labels[item.kind] or source_labels[entry.source.name] or ' '

  return string.format(' │ %s ', label)
end

local function format(entry, item)
  return vim.tbl_extend('force', item, {
    menu = nil,
    abbr = ensure_lengh(item.abbr or '', 50),
    kind = icon(item, entry),
  })
end

return {
  fields = { 'abbr', 'kind' },
  format = format,
}
