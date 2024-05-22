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

  return vim
    .iter(node:iter_children())
    :filter(function(child)
      return vim.tbl_contains(types, child:type())
    end)
    :map(function(child)
      return M.get_node_text(child)
    end)
    :join(separator)
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
