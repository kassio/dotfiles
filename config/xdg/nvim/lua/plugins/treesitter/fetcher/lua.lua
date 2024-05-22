local tsutils = require('plugins.treesitter.utils')

return {
  type_patterns = {
    'field',
    'variable_list',
    'function_declaration',
  },
  transform_fn = function(node)
    local text = tsutils.get_node_text(node:field('name')[1]) or ''
    if text == '' then
      return
    end

    local type = node:type()
    if type == 'variable_list' then
      return '󰂡 ' .. text
    elseif type == 'function_declaration' then
      return '󰊕 ' .. text
    elseif type == 'function_definition' then
      return '󰊕 ' .. text
    elseif type == 'field' then
      return '󰇽 ' .. text
    else
      return text
    end
  end,
}
