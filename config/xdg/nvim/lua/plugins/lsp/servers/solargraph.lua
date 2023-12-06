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
      reporters = {},
    },
  },
}
