local directories = {
  controllers = {
    key = 'c',
    dirs = { 'app/controllers', 'ee/app/controllers' },
  },
  database = {
    key = 'd',
    dirs = { 'db' },
  },
  events = {
    key = 'e',
    dirs = { 'app/events', 'ee/app/events' },
  },
  finders = {
    key = 'f',
    dirs = { 'app/finders', 'ee/app/finders' },
  },
  geral = {
    key = 'a',
    dirs = { 'app', 'lib', 'ee/app', 'ee/lib' },
  },
  graphql = {
    key = 'g',
    dirs = { 'app/graphql', 'ee/app/graphql' },
  },
  lib = {
    key = 'l',
    dirs = { 'lib', 'ee/lib' },
  },
  models = {
    key = 'm',
    dirs = { 'app/models', 'ee/app/models' },
  },
  mailers = {
    key = 'M',
    dirs = { 'app/mailers', 'ee/app/mailers' },
  },
  services = {
    key = 's',
    dirs = { 'app/services', 'ee/app/services' },
  },
  spec = {
    key = 't',
    dirs = { 'spec', 'ee/spec' },
  },
  views = {
    key = 'v',
    dirs = { 'app/views', 'ee/app/views' },
  },
  workers = {
    key = 'w',
    dirs = { 'app/workers', 'ee/app/workers' },
  },
  docs = {
    key = 'D',
    extensions = {},
    dirs = { 'doc' },
  },
}

local finder = function(category)
  require('plugins.fuzzyfinder.commands').find_files({
    extensions = category.extensions or { 'rb', 'haml', 'erb' },
    search_dirs = category.dirs,
  })
end

return {
  setup = function(keymap)
    local keymaps = {
      keymap('rr', function()
        vim.ui.select(vim.tbl_keys(directories), {
          prompt = 'Finder in Rails',
        }, function(choice)
          if choice ~= nil then
            finder(directories[choice])
          end
        end)
      end, 'rails'),
    }

    for name, category in pairs(directories) do
      table.insert(
        keymaps,
        keymap('r' .. category.key, function()
          finder(category)
        end, 'rails:' .. name)
      )
    end

    return keymaps
  end,
}
