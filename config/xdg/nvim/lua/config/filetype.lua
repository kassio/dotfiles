local function filetype_syntax(ft, syntax)
  return ft, function()
    vim.opt_local.syntax = syntax
  end
end

vim.filetype.add({
  extension = {
    ['config'] = 'config',
    ['libsonnet'] = 'jsonnet',
    ['jsonnet'] = 'jsonnet',
    ['ndjson'] = filetype_syntax('ndjson', 'json'),
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
    ['.*_spec%.rb'] = filetype_syntax('ruby', 'rspec'),
    ['gitconfig.*'] = filetype_syntax('config', 'dosini'),
  },
})
