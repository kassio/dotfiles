local util = require('lspconfig.util')

return {
  root_dir = util.root_pattern('.git', 'Gemfile'),
  settings = {
    solargraph = {
      completion = true,
      symbols = true,
      diagnostics = true,
      definitions = true,
      hover = true,
      references = true,
      rename = true,
      useBundler = true,
      maxFiles = 20000,
      include = {
        '**/*.rb',
      },
      exclude = {
        '**/spec/**/*',
        'qa/qa/specs/features/**/*',
        'vendor/**/*',
        '.bundle/**/*',
      },
      reporters = {
        'require_not_found',
      },
      require = {
        'actioncable',
        'actionmailer',
        'actionpack',
        'actionview',
        'activejob',
        'activemodel',
        'activerecord',
        'activestorage',
        'activesupport',
      },
    },
  },
}
