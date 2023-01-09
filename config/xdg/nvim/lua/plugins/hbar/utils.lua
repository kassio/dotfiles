local M = {}

--- Build a highlight string with 'Statusline' as base.
--
--- Example:
--
--- highlight = highlighter('a','b')
--- highlight('c','d')
--- => "%#a.b.c.d#"
---@param ... string
---@return function
M.highlighter = function(...)
  local prefix = { ... }

  return function(...)
    local suffix = { ... }

    local path = vim.tbl_flatten({ prefix, suffix })

    return M.highlight(table.concat(path, '.'))
  end
end

--- Build a clickable statusline component
--
--- Example:
--
--- highlight('text')
--- => "%#text#"
---@param name string name of the highlight
---@return string
M.highlight = function(name)
  return string.format('%%#%s#', name)
end

--- Build a clickable statusline component
--
--- Example:
--
--- clickable('text','plugins.test')
--- => "%1@v:lua.require'plugins.text'.on_click@text%X"
---@param text string clickable text
---@param callback_path string module with the `on_click` function
---@return string
M.clickable = function(text, callback_path)
  local callback = callback_path
  local bufnr = vim.api.nvim_get_current_buf()

  return string.format("%%%d@v:lua.require'%s'.on_click@%s%%X", bufnr, callback, text)
end

M.render_component = function(name, ...)
  local component_ok, component = pcall(require, 'plugins.hbar.components.' .. name)
  if not component_ok then
    return ''
  end

  local render_ok, msg = pcall(component.render, ...)
  if not render_ok then
    return ''
  end

  return msg
end

return M
