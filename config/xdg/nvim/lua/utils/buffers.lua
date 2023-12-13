local M = {}

function M.preserve(callback)
  local saved_view = vim.fn.winsaveview()
  callback()
  vim.fn.winrestview(saved_view)
end


function M.name_and_type(bufnr)
  return vim.api.nvim_buf_get_name(bufnr), vim.bo[bufnr].filetype
end

return M
