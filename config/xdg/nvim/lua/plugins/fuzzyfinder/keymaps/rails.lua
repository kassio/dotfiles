local rails = require('plugins.fuzzyfinder.rails')

local function keymap(key, category)
  return {
    '<leader>fr' .. key,
    function()
      rails.find(category)
    end,
    silent = true,
    desc = 'telescope:rails: find' .. (category or ''),
  }
end

local keymaps = { keymap('r') }
for name, category in pairs(rails.categories) do
  table.insert(keymaps, keymap(category.key, name))
end

return keymaps
