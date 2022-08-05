local M = {}
local utils = require('my.utils')
local fn = vim.fn
local api = vim.api

M.trim = function()
  local hlsearch = vim.opt_global.hlsearch:get()
  vim.opt.hlsearch = false

  utils.preserve(function()
    vim.cmd([[silent %s/\v\s+$//e]])
    vim.cmd([[silent %s/\v($\n\s*)+%$//e]])
  end)

  vim.opt.hlsearch = hlsearch
end

M.only = function() -- delete all buffers but current
  local current = api.nvim_win_get_buf(0)
  for _, buf in ipairs(api.nvim_list_bufs()) do
    if buf ~= current then
      api.nvim_buf_delete(buf, { force = true })
    end
  end
end

M.delete_hidden = function() -- delete all hidden buffers
  for _, buf in ipairs(api.nvim_list_bufs()) do
    if vim.tbl_isempty(fn.win_findbuf(buf)) and api.nvim_buf_is_valid(buf) then
      api.nvim_buf_delete(buf, { force = true })
    end
  end
end

M.indent = function()
  utils.preserve(function()
    vim.cmd([[normal! gg=G]])
  end)
end

M.fileicon = function(bufnr)
  local filetype = api.nvim_buf_get_option(bufnr, 'filetype')
  local filename = api.nvim_buf_get_name(bufnr)

  return vim.my.utils.fileicon(filetype, filename)
end

M.ensure_path_and_write = function()
  local path = fn.expand('%:h')
  fn.mkdir(path, 'p')
  vim.cmd('update!')
end

return M
