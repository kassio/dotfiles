local M = {}

--- Preserve window view (position) and search history
---@param callback function
---@return nil
function M.preserve(callback)
  local saved_view = vim.fn.winsaveview()
  local hlsearch = vim.opt_global.hlsearch:get()
  vim.opt.hlsearch = false

  callback()

  vim.opt.hlsearch = hlsearch
  vim.cmd.nohls()
  vim.fn.winrestview(saved_view)
end

function M.name_and_type(bufnr)
  return vim.api.nvim_buf_get_name(bufnr), vim.bo[bufnr].filetype
end

return M
