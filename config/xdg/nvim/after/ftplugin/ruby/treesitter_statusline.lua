--- treesitter statusline
vim.b.treesitter_statusline_options = {
  type_patterns = { 'class', 'module' },
  separator = '',
  transform_fn = function(value, node)
    value, _ = string.gsub(value, '%s*def%s*', '')
    value, _ = string.gsub(value, '%s*class%s*', '')
    value, _ = string.gsub(value, '%s*module%s*', '')
    value, _ = string.gsub(value, '%s*<.*', '')

    if node:type() == 'class' then
      return '::' .. value
    elseif node:type() == 'singleton_class' then
      return ''
    else
      return '::' .. value
    end
  end,
}
