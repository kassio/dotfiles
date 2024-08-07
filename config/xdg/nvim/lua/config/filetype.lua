local function filetype_syntax(ft, syntax)
  return ft, function()
    vim.opt_local.syntax = syntax
  end
end

vim.filetype.add({
  extension = {
    ['conf'] = 'config',
    ['config'] = 'config',
    ['libsonnet'] = 'jsonnet',
    ['jsonnet'] = 'jsonnet',
    ['ndjson'] = filetype_syntax('ndjson', 'json'),
    ['keymap'] = 'c',
  },
  filename = {
    ['.simplecov'] = 'ruby',
    ['Dangerfile'] = 'ruby',
    ['Guardfile'] = 'ruby',
    ['Brewfile'] = 'brewfile',
    ['go.mod'] = 'gomod',
  },
  pattern = {
    ['.*%.json.*'] = 'json',
    ['.*%.irbrc'] = 'ruby',
    ['.*%.pryrc'] = 'ruby',
    ['.*_spec%.rb'] = filetype_syntax('ruby', 'rspec'),
    ['.*gitconfig'] = filetype_syntax('config', 'dosini'),
    ['brewfile.*'] = 'brewfile',
  },
})
