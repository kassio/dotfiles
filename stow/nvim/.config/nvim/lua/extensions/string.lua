function string.camelcase(str)
  return str:gsub('_(.)', str.upper):gsub('^(.)', str.upper)
end

function string.trim(str)
  return tr:gsub('^%s*(.-)%s*$', '%1')
end
