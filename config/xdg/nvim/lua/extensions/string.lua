function string.camelcase(str)
  return str:gsub('_(.)', str.upper):gsub('^(.)', str.upper)
end

function string.trim(str)
  return str:gsub('^%s*(.-)%s*$', '%1')
end
