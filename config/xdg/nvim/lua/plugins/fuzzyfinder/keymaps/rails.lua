local rails = require('plugins.fuzzyfinder.rails')

local finder = function(category)
  require('plugins.fuzzyfinder.commands').find_files({
    extensions = category.extensions or { 'rb', 'haml', 'erb' },
    search_dirs = category.dirs,
  })
end

return {
  setup = function(keymap)
    local keymaps = {
      keymap('rr', 'rails', function()
        vim.ui.select(vim.tbl_keys(rails.categories), {
          prompt = 'Finder in Rails',
        }, function(choice)
          if choice ~= nil then
            finder(rails.categories[choice])
          end
        end)
      end),
    }

    for name, category in pairs(rails.categories) do
      table.insert(
        keymaps,
        keymap('r' .. category.key, 'rails:' .. name, function()
          finder(category)
        end)
      )
    end

    return keymaps
  end,
}
