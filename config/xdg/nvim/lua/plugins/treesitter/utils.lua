local M = {}

function M.ancestor(node, counter)
  counter = counter or 1
  repeat
    if node == nil then
      return
    end

    node = node:parent()
    counter = counter - 1
  until counter < 1

  return node
end

function M.next_children_text(node, types)
  for child in node:iter_children() do
    -- vim.print({ vim.treesitter.get_node_text(child, 0), child:type() })
    if vim.tbl_contains(types, child:type()) then
      return vim.treesitter.get_node_text(child, 0)
    end
  end
end

return M
