local gps = require('nvim-gps')
local theme = require('plugins.highlight.theme')

local go_package = function()
  if vim.bo.filetype ~= 'go' then
    return ''
  end

  for ln = 0, 300, 1 do
    local ok, line = pcall(vim.api.nvim_buf_get_lines, 0, ln, ln + 1, true)
    if not ok then
      return ''
    end

    line = line[1]
    if string.match(line, '^%s*package%.*') ~= nil then
      return string.format(' %s' .. theme.icons.separator, vim.split(line, ' ')[2])
    end

    ln = ln + 1
  end

  return ''
end

return {
  location = function()
    if gps.is_available() then
      return go_package() .. gps.get_location()
    else
      return ''
    end
  end,
}
