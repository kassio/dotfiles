local M = {}

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
  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local filename = vim.api.nvim_buf_get_name(bufnr)

  return require('my.utils').fileicon(filetype, filename)
end

M.fileicon_extend_hl = function(bufnr, hl)
  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local filename = vim.api.nvim_buf_get_name(bufnr)

  return require('my.utils').fileicon_extend_hl(filetype, filename, hl)
end

M.ensure_path_and_write = function()
  local path = vim.fn.expand('%:h')
  vim.fn.mkdir(path, 'p')
  vim.cmd('update!')
end

return M
