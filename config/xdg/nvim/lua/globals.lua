---Reloads a package by name
--If it fails to be loaded the error is printed
---@param name string name of the package to reload
---@return any, any package the value of the package searcher
function _G.R(name)
  package.loaded[name] = nil

  return require(name)
end
