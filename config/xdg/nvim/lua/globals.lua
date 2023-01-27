local inspect_defaults = {
  process = function(item)
    if item == nil then
      return tostring(item)
    else
      return item
    end
  end,
}

-- P = Print with inpect
_G.P = function(anything, o)
  local opts = vim.tbl_deep_extend('keep', o or {}, inspect_defaults)

  print(vim.inspect(anything, opts))

  return anything
end

-- R = Reload
-- Reloads a package by name
-- If it fails to be loaded the error is printed
_G.R = function(name)
  if package.loaded[name] ~= nil then
    package.loaded[name] = nil
  end

  local status, result = pcall(require, name)

  if status then
    return result -- package
  else
    print('Failed to load ' .. name)
    print(result) -- error message
  end
end

_G.Theme = {
  icons = {
    buffer = '',
    bug = '',
    error = '',
    hint = '',
    info = '',
    nvim_lsp = '',
    nvim_lua = '',
    path = 'פּ',
    separator = ' › ',
    snippy = '',
    spell = '暈',
    treesitter = '',
    warn = '',
  },
}
