local original = vim.lsp.buf.format

vim.lsp.buf.format = function(opts)
  original(vim.tbl_extend('keep', opts or {}, {
    name = 'null-ls',
  }))
end

vim.b.treesitter_statusline_options = {
  type_patterns = {
    'field',
    'assignment_statement',
    'variable_declaration',
    'function_declaration',
    'function_definition',
  },
  transform_fn = function(value, node)
    value = value:gsub('local%s+function', '')
    value = value:gsub('local%s+', '')
    value = value:gsub('=.*', '')
    value = value:gsub('function%s*', '')

    if node:type() == 'variable_declaration' then
      value = '󰂡 ' .. value
    elseif node:type() == 'assignment_statement' then
      value = '󰂡 ' .. value
    elseif node:type() == 'function_declaration' then
      value = '󰊕 ' .. value
    elseif node:type() == 'function_definition' then
      value = '󰊕 ' .. value
    elseif node:type() == 'field' then
      value = '󰇽 ' .. value
    end

    return value
  end,
}
