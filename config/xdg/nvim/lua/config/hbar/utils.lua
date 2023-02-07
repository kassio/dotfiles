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

M.clickables = {}

local clickable_if_for = function(bufnr, path, args)
  local str = tostring(bufnr) .. path .. vim.inspect(args, { newline = '', indent = '' })
  local result = 0
  for i = 1, #str do
    result = result + string.byte(str, i, i)
  end
  return result
end

M.clickable = function(id, click_count, mouse_btn, modifiers)
  M.clickables[id](click_count, mouse_btn, modifiers)
end

local render_component = function(name, ...)
  local args = ... or {}
  local path = 'config.hbar.components.' .. name
  local component_ok, component = pcall(require, path)
  if not component_ok then
    return ''
  end

  local render_ok, result = pcall(component.render, args)
  if not render_ok then
    return ''
  end

  if type(result) == 'string' then
    result = { formatted = result, raw = result }
  end

  if args['clickable'] and component.on_click ~= nil then
    local bufnr = vim.api.nvim_get_current_buf()

    local clickable_id = clickable_if_for(bufnr, path, args)
    M.clickables[clickable_id] = function(click_count, mouse_btn, modifiers)
      component.on_click(result.raw, {
        click_count = click_count,
        mouse_btn = mouse_btn,
        modifiers = modifiers,
      })
    end

    local s = string.format(
      "%%%d@v:lua.require'config.hbar.utils'.clickable@%s%%X",
      clickable_id,
      result.formatted
    )
    return s
  else
    return result.formatted
  end
end

--- Renders a hbar component,
--- all extra arguments are passed to the component render() function
--- if the component has a on_click() function, it makes the rendered text clickable.
--
--- Example:
--
-- -- component:
-- {
--   render = function(arg1, arg2),
--   on_click = function(bufnr, click_count, mouse_btn, modifier)
-- }
--
--- render_component('name', 'arg1', 'arg2')
--
--- => "%1@v:lua.require'plugins.text'.on_click@text%X"
--
---@param name string clickable text
---@param ... any render extra arguments (passed as table)
---@return string
M.render_component = function(name, ...)
  local ok, text = pcall(render_component, name, ...)

  if ok then
    return text
  else
    return name
  end
end

return M
