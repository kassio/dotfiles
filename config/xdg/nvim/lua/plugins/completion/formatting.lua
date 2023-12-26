local kind_icons = {
  Text = '',
  Method = '󰆧',
  Function = '󰊕',
  Constructor = '',
  Field = '󰇽',
  Variable = '󰂡',
  Class = '󰠱',
  Interface = '',
  Module = '',
  Property = '󰜢',
  Unit = '',
  Value = '󰎠',
  Enum = '',
  Keyword = '󰌋',
  Snippet = '',
  Color = '󰏘',
  File = '󰈙',
  Reference = '',
  Folder = '󰉋',
  EnumMember = '',
  Constant = '󰏿',
  Struct = '',
  Event = '',
  Operator = '󰆕',
  TypeParameter = '󰅲',
}

local function ensure_lengh(content, length)
  if #content > length then
    return vim.fn.strcharpart(content, 0, length - 1) .. '…'
  end

  return content .. string.rep(' ', length - #content)
end

return {
  fields = { 'abbr', 'kind' },
  format = function(_entry, item)
    return vim.tbl_extend('force', item, {
      menu = nil,
      abbr = ensure_lengh(item.abbr or '', 50),
      kind = string.format('%s %s', kind_icons[item.kind], item.kind),
    })
  end,
}
