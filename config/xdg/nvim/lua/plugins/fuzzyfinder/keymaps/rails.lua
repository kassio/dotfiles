local rails = require('plugins.fuzzyfinder.rails')

local function railsmap(keymap, key, name, category)
  return keymap('r' .. key, 'rails:' .. (name or ''), function()
    rails.find(category)
  end)
end

return {
  setup = function(keymap)
    local keymaps = { railsmap(keymap, 'r') }

    for name, category in pairs(rails.categories) do
      table.insert(
        keymaps,
        railsmap(keymap, category.key, name, function()
          rails.find(category)
        end)
      )
    end

    return keymaps
  end,
}
