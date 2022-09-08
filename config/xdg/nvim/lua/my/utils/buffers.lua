local M = {}
local icon_custom_with_custom_bg = {}

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

M.fileicon_custom_bg = function(bufnr, bg_hl)
  local hlutil = require('my.utils.highlights')
  local icon, icon_hl = M.fileicon(bufnr)
  local bg = hlutil.get(bg_hl).background

  if bg == nil then
    return icon, icon_hl
  end

  local name = icon_hl .. bg

  if icon_custom_with_custom_bg[name] == nil then
    hlutil.def(name, {
      foreground = hlutil.get(icon_hl).foreground,
      background = bg,
    })

    icon_custom_with_custom_bg[name] = true
  end

  return icon, name
end

M.ensure_path_and_write = function()
  local path = vim.fn.expand('%:h')
  vim.fn.mkdir(path, 'p')
  vim.cmd('update!')
end

return M
