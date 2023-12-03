local M = {}

function M.preserve(callback)
  local saved_view = vim.fn.winsaveview()
  callback()
  vim.fn.winrestview(saved_view)
end

function M.trim()
  local hlsearch = vim.opt_global.hlsearch:get()
  vim.opt.hlsearch = false

  M.preserve(function()
    vim.cmd([[keeppatterns silent %s/\v\s+$//e]])
    vim.cmd([[keeppatterns silent %s/\v($\n\s*)+%$//e]])
  end)

  vim.opt.hlsearch = hlsearch
end

function M.name_and_type(bufnr)
  return vim.api.nvim_buf_get_name(bufnr), vim.bo[bufnr].filetype
end

return M
