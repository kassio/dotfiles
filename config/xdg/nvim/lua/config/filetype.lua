local function syntax(name)
  return function()
    vim.opt_local.syntax = name
  end
end

vim.filetype.add({
  extension = {
    ['config'] = 'config',
    ['libsonnet'] = 'jsonnet',
    ['jsonnet'] = 'jsonnet',
    ['ndjson'] = function()
      return 'ndjson', syntax('json')
    end,
  },
  filename = {
    ['.simplecov'] = 'ruby',
    ['Dangerfile'] = 'ruby',
    ['Brewfile'] = 'brewfile',
    ['go.mod'] = 'gomod',
  },
  pattern = {
    ['.*%.json.*'] = 'json',
    ['.*%.irbrc'] = 'ruby',
    ['.*%.pryrc'] = 'ruby',
    ['.*_spec%.rb'] = function()
      return 'ruby', syntax('rspec')
    end,
    ['gitconfig.*'] = function()
      return 'config', syntax('dosini')
    end,
  },
})
