return {
  setup = function(ffinder)
    local function rails_keymap(key, paths, name)
      local search_path = vim.iter(paths):fold('', function(result, path)
        return vim.trim(string.format([[%s --search-path %s]], result, path))
      end)

      vim.keymap.set('n', '<leader>fr' .. key, function()
        ffinder.files({
          fd_opts = string.format('--type f %s', search_path),
          prompt = string.format('rails:%s> ', name),
        })
      end, { desc = string.format('find:rails:%s', name) })
    end

    rails_keymap('a', { 'ee/app', 'app', 'ee/lib', 'lib' }, 'application and library')
    rails_keymap('c', { 'ee/app/controllers', 'app/controllers' }, 'controllers')
    rails_keymap('f', { 'ee/app/finders', 'app/finders' }, 'finders')
    rails_keymap('g', { 'ee/app/graphql', 'app/graphql' }, 'graphql')
    rails_keymap('l', { 'ee/lib', 'lib' }, 'library')
    rails_keymap('m', { 'ee/app/models', 'app/models' }, 'models')
    rails_keymap('s', { 'ee/app/services', 'app/services' }, 'services')
    rails_keymap('v', { 'ee/app/views', 'app/views' }, 'views')
    rails_keymap('w', { 'ee/app/workers', 'app/workers' }, 'workers')
    rails_keymap('t', { 'app/test', 'ee/spec', 'spec' }, 'tests')
  end,
}
