local M = {}

function M.get_node_text(node, source, opts)
  if not node then
    return ''
  end

  return vim.treesitter.get_node_text(node, source or 0, opts or {})
end

function M.ancestor(node, counter)
  counter = counter or 0
  while node and counter > 0 do
    node = node:parent()
    counter = counter - 1
  end

  return node
end

function M.next_children_text(node, separator, types)
  if not node then
    return ''
  end

  local list = {}
  for child in node:iter_children() do
    if vim.tbl_contains(types, child:type()) then
      table.insert(list, M.get_node_text(child))
    end
  end

  return table.concat(list, separator)
end

function M.ancestors_by_type(node, types)
  while node do
    node = node:parent()

    if node and vim.tbl_contains(types, node:type()) then
      return node
    end
  end
end

return M
