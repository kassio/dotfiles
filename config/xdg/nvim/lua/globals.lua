local inspect_defaults = {
  newline = '',
  indent = '',
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
  package.loaded[name] = nil

  return require(name)
end
