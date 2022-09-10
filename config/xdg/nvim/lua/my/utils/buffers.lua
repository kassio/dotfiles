local M = {}

local bufer_name_and_type = function(bufnr)
  return vim.api.nvim_buf_get_name(bufnr), vim.api.nvim_buf_get_option(bufnr, 'filetype')
end

M.preserve = function(callback)
  local saved_view = vim.fn.winsaveview()
  callback()
  vim.fn.winrestview(saved_view)
end

M.trim = function()
  local hlsearch = vim.opt_global.hlsearch:get()
  vim.opt.hlsearch = false

  M.preserve(function()
    vim.cmd([[silent %s/\v\s+$//e]])
    vim.cmd([[silent %s/\v($\n\s*)+%$//e]])
  end)

  vim.opt.hlsearch = hlsearch
end

M.fileicon = function(bufnr)
  local filename, filetype = bufer_name_and_type(bufnr)

  return require('my.utils').fileicon(filetype, filename)
end

M.fileicon_extend_hl = function(bufnr, hl)
  local filename, filetype = bufer_name_and_type(bufnr)

  return require('my.utils').fileicon_extend_hl(filetype, filename, hl)
end

return M
