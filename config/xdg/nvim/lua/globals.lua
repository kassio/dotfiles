-- R = Reload
-- Reloads a package by name
-- If it fails to be loaded the error is printed
_G.R = function(name)
  package.loaded[name] = nil

  return require(name)
end
