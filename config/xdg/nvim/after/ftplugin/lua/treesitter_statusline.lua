local tsutils = R('plugins.treesitter.utils')

vim.b.treesitter_statusline_options = {
  type_patterns = {
    'field',
    'variable_list',
    'function_declaration',
  },
  transform_fn = function(_line, node)
    local text = tsutils.next_children_text(node, { 'identifier' }) or ''

    if node:type() == 'variable_list' then
      return '󰂡 ' .. text
    elseif node:type() == 'function_declaration' then
      return '󰊕 ' .. text
    elseif node:type() == 'function_definition' then
      return '󰊕 ' .. text
    elseif node:type() == 'field' then
      return '󰇽 ' .. text
    else
      return text
    end
  end,
}
