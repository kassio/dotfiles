local directories = {
  app_code = {
    key = 'a',
    dirs = { 'app', 'lib', 'ee/app', 'ee/lib' },
  },
  config = {
    dirs = { 'config', 'ee/config' },
    extensions = {},
  },
  database = {
    dirs = { 'db' },
  },
  assets = {
    dirs = { 'app/assets', 'ee/app/assets' },
    extensions = {},
  },
  channels = {
    dirs = { 'app/channels', 'ee/app/channels' },
  },
  components = {
    dirs = { 'app/components', 'ee/app/components' },
  },
  controllers = {
    key = 'c',
    dirs = { 'app/controllers', 'ee/app/controllers' },
  },
  enums = {
    dirs = { 'app/enums', 'ee/app/enums' },
  },
  events = {
    key = 'e',
    dirs = { 'app/events', 'ee/app/events' },
  },
  experiments = {
    dirs = { 'app/experiments', 'ee/app/experiments' },
  },
  finders = {
    key = 'f',
    dirs = { 'app/finders', 'ee/app/finders' },
  },
  graphql = {
    key = 'g',
    dirs = { 'app/graphql', 'ee/app/graphql' },
  },
  helpers = {
    dirs = { 'app/helpers', 'ee/app/helpers' },
  },
  mailers = {
    dirs = { 'app/mailers', 'ee/app/mailers' },
  },
  models = {
    key = 'm',
    dirs = { 'app/models', 'ee/app/models' },
  },
  policies = {
    dirs = { 'app/policies', 'ee/app/policies' },
  },
  presenters = {
    dirs = { 'app/presenters', 'ee/app/presenters' },
  },
  services = {
    key = 's',
    dirs = { 'app/services', 'ee/app/services' },
  },
  uploaders = {
    dirs = { 'app/uploaders', 'ee/app/uploaders' },
  },
  validators = {
    dirs = { 'app/validators', 'ee/app/validators' },
  },
  views = {
    key = 'v',
    dirs = { 'app/views', 'ee/app/views' },
  },
  workers = {
    key = 'w',
    dirs = { 'app/workers', 'ee/app/workers' },
  },
  lib = {
    key = 'l',
    dirs = { 'lib', 'ee/lib' },
  },
  spec = {
    key = 't',
    dirs = { 'spec', 'ee/spec' },
  },
  docs = {
    key = 'D',
    extensions = {},
    dirs = { 'doc' },
  },
}

local function finder(category)
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
      if category.key then
        table.insert(
          keymaps,
          keymap('r' .. category.key, function()
            finder(category)
          end, 'rails:' .. name)
        )
      end
    end

    return keymaps
  end,
}
