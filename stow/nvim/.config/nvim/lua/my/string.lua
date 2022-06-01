function string.camelcase(str)
  return str:gsub('_(.)', str.upper):gsub('^(.)', str.upper)
end
