local gps = require('nvim-gps')

return {
  location = function()
    if gps.is_available() then
      return go_package() .. gps.get_location()
    else
      return ''
    end
  end,
}
