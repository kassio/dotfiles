local ignored = {
  "vim.tbl_flatten"
}

local original_deprecate = vim.deprecate

vim.deprecate = function(name, alternative, version, plugin, backtrace)
  if vim.tbl_contains(ignored, name) then
    return
  end

  return original_deprecate(name, alternative, version, plugin, backtrace)
end
